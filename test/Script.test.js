const TokenFactory  = artifacts.require("TokenFactory")


contract("TokenFactory",(accounts)=>{
    let tokenFactory
    beforeEach(async ()=>{
         tokenFactory = await TokenFactory.deployed()
    })
    describe("Deploya um ERC20 de nome MAteus e totalSupply 100",()=>{
        it("ativa a funcao com os parametros corretos",async()=>{
            
            

            await tokenFactory.deployERC20("Mateus","MTS",100)
            
            
        })
    })
})