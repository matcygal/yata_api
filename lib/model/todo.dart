import '../rest.dart';

class Todo extends ManagedObject<_Todo> implements _Todo {

}

class _Todo {
    @primaryKey
    int id;
    
    @Column()
    String title;

    @Column()
    String description;

    @Column()
    String status;

    @Column()
    int userId;

    @Column()
    int teamId;

    @Column()
    int mainId;

    @Column()
    bool isMain;
    
    @Column()
    int dateDue;

    @Column()
    int dateUpdated;

    @Column()
    int dateCreated;
}
