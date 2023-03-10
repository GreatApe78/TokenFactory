const HDWalletProvider = require('@truffle/hdwallet-provider'); //Lembre-se de instalar essa biblioteca para deploiar os contratos nas redes remotas (Mainnet, Rinkeby, Ropsten, Goerli, etc)
const DOTENV = require("dotenv");
DOTENV.config();



 //Leitura da frase secreta contida no arquivo .secret
//const infuraKey = process.env.infuraKey
//const mnemonic = process.env.mnemonic
const MNEMONIC = process.env._mnemonic;
const GOERLI_KEY = process.env._goerliKey;
const BINANCE_KEY = process.env._binanceKey;
const FANTOM_KEY = process.env._fantomKey
module.exports = {
  networks: {
    development: { //Use esse nome se quiser deploiar no ganache pelo terminal. Para usar a interface grafica, use a porta 7545
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
    },
    goerli: { //Exemplo de rede de teste. Para usar outra rede, basta adiciona-la trocando o nome, o id da rede e a chave do infura correspondente
      provider: () => new HDWalletProvider(MNEMONIC, GOERLI_KEY),
      network_id: 5,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 600,
      skipDryRun: true
    },
    binanceTestnet: {
      provider: () => new HDWalletProvider(MNEMONIC, BINANCE_KEY),
      network_id: 97,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 600,
      skipDryRun: true
    },

    fantomTestnet: {
      provider: () => new HDWalletProvider(MNEMONIC, FANTOM_KEY),
      network_id: 4002,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 600,
      skipDryRun: true
    }
  },
  compilers: {
    solc: {
      version: "^0.8.2",    //Essa versao deve ser a mesma utilizada nos contratos Solidity. Se mudar a versao dos contratos, mude a versao aqui tambem
    }
  },
}
//importar web3 front ___web3cdn___