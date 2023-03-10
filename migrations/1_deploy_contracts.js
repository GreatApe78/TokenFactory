const ERC20Template = artifacts.require("ERC20Template")
const TokenFactory = artifacts.require("TokenFactory")
const ERC721Template = artifacts.require("ERC721Template")

module.exports = async (deployer,network,accounts)=>{
    
    //await deployer.deploy(TokenFactory)

    await deployer.deploy(ERC721Template, "colecao", "CLC","https://gateway.pinata.cloud/ipfs/QmXQqzRiLjutSQME3USvgHJsNEJ972hHou8AcqQsUbeGjz/",".svg")

} 
//tf.deployERC20("Mateus", "MTS", 5000)