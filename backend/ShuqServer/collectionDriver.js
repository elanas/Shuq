/**
 * @fileoverview a helper class that handles a lot of interactions with the mongodb database
 */

//var ObjectID = require('mongodb').ObjectID;

/**
 * The constructor for a collection driver object
 * @param db the database this collectiondriver deals with
 * @constructor
 */
CollectionDriver = function(db) {
  this.db = db;
};

/**
 * The function that gets a collection
 * @param collectionName the name of the collction to get
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
          else callback(null, results)
        });
      }
    });
};

CollectionDriver.prototype.match = function(collectionName, user, callback) {
  this.getCollection(collectionName, function(error, the_collection) {
    if (error) callback(error);
    else {
      var wishlist;
      the_collection.findOne({'username':user}, function(error,doc) {
        if (error) callback(error);
        else {
          wishlist = doc['wishlist'];
          the_collection.find({ "inventory.items" :{$in:wishlist['items']}}, function(error, docs) {
            docs.toArray(function(error, results) {
              console.log(results);
            });
            docs.each(function(user) {
              console.log(user);
            });
            docs.toArray(function(error, theArray) {
              callback(null, theArray);
            });
          });
        }
      });
    }
  });

}

CollectionDriver.prototype.check = function(collectionName, user, callback) {
  this.getCollection(collectionName, function(error, the_collection) {
    if (error) callback(error);
    else {
      the_collection.findOne({'username':user}, function(error, doc) {
        if(doc) {
          callback(null, doc);
        } else {
          callback(error);
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

exports.CollectionDriver = CollectionDriver;
