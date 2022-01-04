import NonFungibleToken from 0x631e88ae7f1d7c20
import Brattiez from 0x5fe768dcd932aa30

// This transction uses the createEmptyCollection() to create
// Brattiez Collection for account 


transaction {
    prepare(signer: AuthAccount) {
        // if the account doesn't already have a collection
        if signer.borrow<&Brattiez.Collection>(from: Brattiez.CollectionStoragePath) == nil {

            // create a new empty collection
            let collection <- Brattiez.createEmptyCollection()
            
            // save it to the account
            signer.save(<-collection, to: Brattiez.CollectionStoragePath)

            // create a public capability for the collection
            signer.link<&Brattiez.Collection{NonFungibleToken.CollectionPublic, Brattiez.BrattiezCollectionPublic}>(Brattiez.CollectionPublicPath, target: Brattiez.CollectionStoragePath)
        }
    }
}