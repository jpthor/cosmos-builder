# Building and running the application

## Building the `nameservice` application

If you want to build the `nameservice` application in this repo to see the functionalities, **Go 1.12.1+** is required .

Add some parameters to environment is necessary if you have never used the `go mod` before.

```bash
mkdir -p $HOME/go/bin
echo "export GOPATH=$HOME/go" >> ~/.bash_profile
echo "export GOBIN=\$GOPATH/bin" >> ~/.bash_profile
echo "export PATH=\$PATH:\$GOBIN" >> ~/.bash_profile
echo "export GO111MODULE=on" >> ~/.bash_profile
source ~/.bash_profile
```

Now, you can install and run the application.

```bash
# Install the app into your $GOBIN
make install

# Now you should be able to run the following commands:
csd help
cscli help
```

## Running the live network and using the commands

To initialize configuration and a `genesis.json` file for your application and an account for the transactions, start by running:

> _*NOTE*_: In the below commands addresses are are pulled using terminal utilities. You can also just input the raw strings saved from creating keys, shown below. The commands require [`jq`](https://stedolan.github.io/jq/download/) to be installed on your machine.

> _*NOTE*_: If you have run the tutorial before, you can start from scratch with a `csd unsafe-reset-all` or by deleting both of the home folders `rm -rf ~/.ns*`

> _*NOTE*_: If you have the Cosmos app for ledger and you want to use it, when you create the key with `cscli keys add jack` just add `--ledger` at the end. That's all you need. When you sign, `jack` will be recognized as a Ledger key and will require a device.

```bash
# Initialize configuration files and genesis file
  # moniker is the name of your node
csd init <moniker> --chain-id cschain


# Copy the `Address` output here and save it for later use
# [optional] add "--ledger" at the end to use a Ledger Nano S
cscli keys add jack

# Copy the `Address` output here and save it for later use
cscli keys add alice

# Add both accounts, with coins to the genesis file
csd add-genesis-account $(cscli keys show jack -a) 1000cstoken,100000000stake
csd add-genesis-account $(cscli keys show alice -a) 1000cstoken,100000000stake

# Configure your CLI to eliminate need for chain-id flag
cscli config chain-id cschain
cscli config output json
cscli config indent true
cscli config trust-node true

csd gentx --name jack <or your key_name>
```

After you have generated you a genesis transcation, you will have to input the gentx into the genesis file, so that your nameservice chain is aware of the validators. To do so, run:

`csd collect-gentxs`

and to make sure your genesis file is correct, run:

`csd validate-genesis`

You can now start `csd` by calling `csd start`. You will see logs begin streaming that represent blocks being produced, this will take a couple of seconds.

Open another terminal to run commands against the network you have just created:

```bash
# First check the accounts to ensure they have funds
cscli query account $(cscli keys show jack -a)
cscli query account $(cscli keys show alice -a)

# Buy your first name using your coins from the genesis file
cscli tx nameservice buy-name jack.id 5cstoken --from jack

# Set the value for the name you just bought
cscli tx nameservice set-name jack.id 8.8.8.8 --from jack

# Try out a resolve query against the name you registered
cscli query nameservice resolve jack.id
# > 8.8.8.8

# Try out a whois query against the name you just registered
cscli query nameservice whois jack.id
# > {"value":"8.8.8.8","owner":"cosmos1l7k5tdt2qam0zecxrx78yuw447ga54dsmtpk2s","price":[{"denom":"cstoken","amount":"5"}]}

# Alice buys name from jack
cscli tx nameservice buy-name jack.id 10cstoken --from alice
```

### Congratulations, you have built a Cosmos SDK application! This tutorial is now complete. If you want to see how to run the same commands using the REST server [click here](run-rest.md).
