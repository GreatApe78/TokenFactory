const ERC20Template = artifacts.require("ERC20Template")

const ERC721Template = artifacts.require("ERC721Template")
const TokenFactoryERC721 = artifacts.require("TokenFactoryERC721")
module.exports = async (deployer,network,accounts)=>{
    
    //await deployer.deploy(TokenFactory)

    await deployer.deploy(TokenFactoryERC721)

} 
//tf.deployERC20("Mateus", "MTS", 5000)