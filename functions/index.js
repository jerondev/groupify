const functions = require("firebase-functions")
const admin = require("firebase-admin")
admin.initializeApp()

// create a cloud function that will check if messages were sent successfully and then update the isSent field on the message using firestore transaction
exports.updateIsSent = functions.firestore
  .document(`{collection}/{documentId}/messages/{messageId}`)
  .onCreate(async function (snap, context) {
    return admin.firestore().runTransaction(async function (transaction) {
      return transaction.get(snap.ref).then(function (doc) {
        if (doc.data().isSent) {
          return Promise.resolve("Message already sent")
        }
        return transaction.update(snap.ref, { isSent: true })
      })
    })
  })
