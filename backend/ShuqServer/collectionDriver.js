/**
 * @fileoverview the helper class that handles a lot of interactions with the mongodb database
 * @type {exports.ObjectID|*}
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


/**
 * Grabs an specific object from a collection
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
        the_collection.insert(obj, function() {
          callback(null, obj);
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