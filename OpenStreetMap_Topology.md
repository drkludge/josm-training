# OpenStreetMap Topology

There are three primary pieces of the OpenStreetMap topology: Node, Way, and Relation. Two supporting pieces of the topology are mappers and changesets.  All five of these pieces of the topology work together to build the map.

1. A user id and user name are assigned when a new mapper signs up for at the OpenStreetMap website.
2. A changset id is created when a mapper makes a change to the map. A changset is composed of tags about the change and nodes, wayys, or relations.
3. A node is the basic building block of the geometry.
4. A way strings nodes together to form a line or polygon.
5. A relation strings nodes, ways, or other relations together to form more "advanced" geometries such as a donut.

The following tables provide the very basics of the primary pieces of the OpenStretMap topology.  Various file formats are used to add additional control information such as a modified state before parts of the topology are saved.

OpenStreetmap editors and the OpenStreetmap API maintain the sys oriented fields.  An edit, at the simplest form, is a mapper changing longitude, latitude, tags, and stringing nodes, ways, or relations together.

## Node

| Field | Value     | By   | Description                 
|-------|-----------|------|------------------------------------|
| node id | 27195239 | sys  | A unique number is associated with each node.  The number is assigned when the node is uploaded to the OpenStreetMap database.  The number is in a difference sequence group than a way or relation.
| timestamp | 2013-07-11T17:19:11Z | sys  | The date and time that the node was created or modified is stored with each edit of the node.
| uid  | 7168 | sys  | OpenStreetMap assigned user id number that added or modified the node.
| user | DaveHansenTiger | sys  | The mapper name that added or modified the node. |
| version | 3 | sys  | A version number is stored with each id.  The version number establishes the history of the node. |
| changeset | 9708 | sys  | Changeset is an api 0.6 feature
| lat | 34.0009617 | user | The longitude is stored in the OpenStreetMap database as an integer for performance reasons. 34.0009617 becomes 340009617 when stored in the database. The format that is implied is NNNDDDDDDD.
| lon | -114.2153044 | user | The longitude is stored in the OpenStreetMap database as an integer for performance reasons. -114.2153044 becomes -1142153044 when stored in the database. The format that is implied is NNNDDDDDDD.
| tag |   | user | One or more tags are stored with a node.
| tag | k | user | k for key. A key value is an agreed upon way of representing features to add to the map.
| tag | v | user | v for value. A value may be a name or predefine value.


  ## Way
  
| Field | Value     | By   | Description                 
|-------|-----------|------|------------------------------------|
| way id | 157583776 | sys  | A unique number is associated with each way.  The number is assigned when the way is uploaded to the OpenStreetMap database. The number is in a difference sequence group than a node or relation.
| timestamp | 2013-07-11T17:19:11Z | sys  | The date and time that the way was created or modified is stored with each edit of the way.
| uid  | 7168 | sys  | OpenStreetMap assigned user id number that added or modified the node.
| user | DaveHansenTiger | sys  | The mapper name that added or modified the node. |
| version | 3 | sys  | A version number is stored with each id.  The version number establishes the history of the node. |
| changeset | 9708 | sys  | Changeset is an api 0.6 feature
| nd  |     | user | Two or more node ids are refenced to provide the geometry of the way.
| nd  | ref | user | 1698222295 
| nd  | ref | user | 1698222290
| tag |   | user | One or more tags are stored with a way such as  k='highway' v='service'.
| tag | k | user |  k for key. A key value is an agreed upon way of representing features to add to the map.
| tag | v | user |  v for value. A value may be a name or predefine value.

  ## Relation
  
| Field | Value     | By   | Description                 
|-------|-----------|------|------------------------------------|
| relation id | 157583776 | sys  | A unique number is associated with each relation.  The number is assigned when the relation is uploaded to the OpenStreetMap database. The number is in a difference sequence group than a node or way.
| timestamp | 2013-07-11T17:19:11Z | sys  | The date and time that the relation was created or modified is stored with each edit of the relation.
| uid | 7168 | sys  | OpenStreetMap assigned user id number that added or modified the node.
| user | DaveHansenTiger | sys  | The mapper name that added or modified the node. |
| version | 3 | sys  | A version number is stored with each id.  The version number establishes the history of the node. |
| changeset | 9708 | sys  | Changeset is an api 0.6 feature
| member |  | user | One or more nodes, ways, or relations are referenced to complete the geometry.
| member | type | user | A value of node, way, rel
| member | ref | user | The node, way or relations OpenStreetMap id.
| member | role | user | Depending on what the relation is defining a role may be provided.  For example a building with a courtyard would have two ways.  One role would be marked outer and the other role would be marked inner.
| tag |   | user | One or more tags are stored with a relation.
| tag | k | user | k for key. A key value is an agreed upon way of representing features to add to the map.
| tag | v | user | v for value. A value may be a name or predefine value.
