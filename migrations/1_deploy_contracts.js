const ERC20Template = artifacts.require("ERC20Template")
const TokenFactory = artifacts.require("TokenFactory")


module.exports = async (deployer,network,accounts)=>{
    
    await deployer.deploy(TokenFactory)
    let tf = await TokenFactory.deployed()
    await tf.deployERC20("Mateus", "MTS", 5000)
    await tf.transferERC20()
    
} 
//tf.deployERC20("Mateus", "MTS", 5000)