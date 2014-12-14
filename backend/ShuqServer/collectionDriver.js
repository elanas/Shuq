/**
 * @fileoverview a helper class that handles a lot of interactions with the mongodb database
 */

//var ObjectID = require('mongodb').ObjectID;
var cDriver;


/**
 * The constructor for a collection driver object
 * @param db the database this collectiondriver deals with
 * @constructor
 */
CollectionDriver = function(db) {
  this.db = db;
  cDriver = this;
};

CollectionDriver.matches = [];

/**
 * The function that gets a collection
 * @param collectionName the name of the collection to get
 * @param callback the callback response
 */
CollectionDriver.prototype.getCollection = function(collectionName, callback) {
  this.db.collection(collectionName, function(error, the_collection) {
    if( error ) callback(error);
    else callback(null, the_collection);
  });
};


/**
 * Finds all the objects in the specified collection
 * @param collectionName the name of the collection whose objects you want
 * @param callback the callback response
 */
CollectionDriver.prototype.findAll = function(collectionName, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
      if( error ) callback(error);
      else {
        the_collection.find().toArray(function(error, results) {
          if( error ) callback(error);
          else callback(null, results);
        });
      }
    });
};

CollectionDriver.prototype.makeAllMatches = function(collectionName, callback) {
  this.findAll(collectionName, function(error, allUsers) {
    if (error) callback(error);
    else {
      for (var i=0; i<allUsers.length; i++) {
        var currentMatches = cDriver.matchesForOne(allUsers[i], allUsers);
        var userString = allUsers[i].username.concat("Matches");
        cDriver.deleteAll(userString, function(error, noerror) {
          if (error) callback(error);
          else {
            cDriver.save(userString, currentMatches, function(error, response) {
              if (error) callback(error);
            });
          }
        });
      callback(null, "Matches Done");
      }
    }
  });
};


CollectionDriver.prototype.demoMakeMatches = function(collectionName, id, callback) {
  var stringMatchCollection = id.concat("Matches");
  this.deleteAll(stringMatchCollection, function(error, response) {
    if (error) callback(error);
    else
    {
      cDriver.get(collectionName, id, function(error, user) {
        if (error) callback(error);
        else {
          cDriver.findAll(collectionName, function(error, allUsers) {
            if (error) callback(error);
            else {
              var arrayOfMatches = cDriver.matchesForOne(user, allUsers);
              if (arrayOfMatches.length != 0) {
                cDriver.save(stringMatchCollection, arrayOfMatches, function(error, response) {
                  if (error) callback(error);
                  else callback(response);
                });
              } else {
                callback(null, "No Matches");
              }
            }
          });
        }
      });
    }
  });
};


/**
 * Helper function to make all matches for a specific user.
 * Creates match JSONs for every match and returns an array of them.
 * @param userToMatch the user Json for whom we will find matches
 * @param arrayOfUsers the array of all users within which we should check for matches
 * @return an array of match Jsons
 */
CollectionDriver.prototype.matchesForOne = function(userToMatch, arrayOfUsers) {
  var matchedObjectsArray = [];

  // for every user in arrayOfUsers
  for (var i=0; i<arrayOfUsers.length; ++i) {
    var otherUser = arrayOfUsers[i];

    //don't match John with himself. Skip John
    if (otherUser.username == userToMatch.username) {
      continue;
    }


    //don't match users that are too far
    if (!(this.testZip(otherUser.location, userToMatch.location))) {
        continue;
    }

    var otherHas = [];
    var otherWants = [];



    // check if he has something John wants
    // for every item in John's wishlist
    for (var j=0; j<userToMatch.wishlist.items.length; ++j) {
      //for every item in user i's inventory
      for (var k=0; k<otherUser.inventory.items.length; ++k) {
        var othersItem = otherUser.inventory.items[k];

        if (othersItem.name.toLowerCase() != userToMatch.wishlist.items[j].name.toLowerCase()) {
          continue;
        }

        otherHas.push(othersItem);
      }

    }

    if (otherHas.length == 0) {
      continue;
    }



    //check the other direction (what John has that other wants)
    // for every item in John's inventory
    for (var j=0; j<userToMatch.inventory.items.length; ++j) {
      //for every item in user i's wishlist
      for (var k=0; k<otherUser.wishlist.items.length; ++k) {
        var myItem = userToMatch.inventory.items[j];

        if (myItem.name.toLowerCase() != otherUser.wishlist.items[k].name.toLowerCase()) {
          continue;
        }

        otherWants.push(myItem);
        console.log(otherWants);
      }
    }

    if (otherWants.length == 0) {
      continue;
    }

    var score = this.genScore(otherUser.location, userToMatch.location, otherHas, otherWants);
    //Store a match object representing this match
    var matchObject =
        {
          username: otherUser.username,
          _id: otherUser.username,
          userHas: otherHas,
          userWants: otherWants,
          score: score,
          rank: 0
        };

    matchedObjectsArray.push(matchObject);
  }

  matchedObjectsArray.sort(function(a,b) {
    return b.score - a.score;
  });

  for (var i=0; i<matchedObjectsArray.length; ++i) {
    matchedObjectsArray[i].rank = i+1;
  }

  return matchedObjectsArray;
};

CollectionDriver.prototype.testZip = function(zip1, zip2) {
  var int1 = parseInt(zip1);
  var int2 = parseInt(zip2);
  int1 = int1/1000;
  int2 = int2/1000;
  return (int1 == int2);
};

CollectionDriver.prototype.genScore = function(zip1, zip2, otherHas, otherWants) {
  var totalMatches = otherHas.length + otherWants.length;
  var int1 = parseInt(zip1);
  var int2 = parseInt(zip2);
  return ((10000-(Math.abs(int1 - int2))) + (1000*totalMatches));
};

/*
CollectionDriver.prototype.match = function(collectionName, user, callback) {
  this.getCollection(collectionName, function(error, the_collection) {
    if (error) callback(error);
    else {
      var wishlist;
      the_collection.findOne({'username':user}, function(error,doc) {
        if (error) callback(error);
        else {
          wishlist = doc['wishlist'];
          var potentialMatches = [];
          var items = wishlist['items'];
          var itemsLength = items.length;
          for (var i=0; i<itemsLength; i++) {
            the_collection.find({ "inventory.items" : { $elemMatch: {name: items[i]['name']}}}, function(error, docs) {
              docs.toArray(function(error, results) {
                console.log(results);
              });
              docs.each(function(user) {
                console.log(user);
              });
            });
          }
        }
      });
    }
  });

}
*/
CollectionDriver.prototype.check = function(collectionName, user, callback) {
  this.getCollection(collectionName, function(error, the_collection) {
    if (error) callback(error);
    else {
      the_collection.findOne({'username':user}, function(error, doc) {
        if(doc) {
          callback(null, "Taken");
        } else {
          callback(null, "Free");
        }
      });
    }
  });
}

/**
 * Grabs a specific object from a collection
 * @param collectionName the name of the collection
 * @param id the id of the entity you want to get
 * @param callback the callback response
 */
CollectionDriver.prototype.get = function(collectionName, id, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
        if (error) callback(error);
        else {
            the_collection.findOne({'_id':id}, function(error,doc) {
                if (error) callback(error);
                else callback(null, doc);
            });
        }
    });
};


/**
 * Post an object to the desired collection
 * @param collectionName the name of the collection
 * @param obj the object to put into the collection
 * @param callback the callback response
 */
CollectionDriver.prototype.save = function(collectionName, obj, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
      if( error ) callback(error);
      else {
        obj.created_at = new Date();
/*        the_collection.insert(obj, function() {
          callback(null, obj);
          });
*/      the_collection.insert(obj, function(error, doc) {
            /*if (writeResult.nInserted === 1) {
                callback(null, obj);
            }*/
            if (error) callback(error);
            else {
                callback(null, obj);
            }
        });
      }
    });
};


/**
 * Put/update. Replace an entity in a collection with the given object
 * @param collectionName the name of the collection
 * @param obj the object to put in place of the specified entity
 * @param entityId the id of the entity to be overwritten/updated
 * @param callback the callback response
 */
CollectionDriver.prototype.update = function(collectionName, obj, entityId, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
        if (error) callback(error);
        else {
	        obj._id = entityId;
	        obj.updated_at = new Date();
            the_collection.save(obj, function(error,doc) {
            	if (error) callback(error)
            	else callback(null, obj);
            });
        }
    });
};


CollectionDriver.prototype.partialUpdate = function(collectionName, obj, entityId, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
        if (error) callback(error);
        else {
            the_collection.findOne({'_id': entityId}, function (error, doc) {
                if (error) callback(error);
                else {
                   //RIGHT NOW THIS ASSUMES GOOD INPUT
                    var index;
                    for (index = 0; index < obj.changes.length; ++index) {
                        var change = obj.changes[index];
                        var path = change.path.split(".");
                        var navigator = doc;
                        var j;
                        for (j=0; j<path.length; ++j) {
                            navigator = navigator[path[j]];
                        }

                        if (change.type === "add") {
                            navigator[change.propertyName] = change.propertyValue;

                        } else if (change.type === "remove") {
                            delete navigator[change.propertyName];

                        } else if (change.type === "replace") {
                            navigator = change.propertyValue;

                        }
                    }

                    the_collection.save(doc, function (error, doc2) {
                        if (error) callback(error)
                        else callback(null, doc);
                    });
                }
            });
        }
    });
};


/**
 * Delete an entity from a collection
 * @param collectionName the name of the collection
 * @param entityId the id of the entity to delete
 * @param callback the callback response
 */
CollectionDriver.prototype.delete = function(collectionName, entityId, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
        if (error) callback(error);
        else {
            the_collection.remove({'_id': entityId}, function(error,doc) {
            	if (error) callback(error)
            	else callback(null, doc);
            });
        }
    });
};

CollectionDriver.prototype.deleteAll = function(collectionName, callback) {
    this.getCollection(collectionName, function(error, the_collection) {
        if (error) callback(error);
        else {
          the_collection.remove({}, function(error,doc) {
            	if (error) callback(error)
              else {
                console.log("deleting everything in " + collectionName);
                callback(null, doc);
              }
          });
        }
    });
};

exports.CollectionDriver = CollectionDriver;
