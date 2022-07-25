trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete) {
    new ContactTriggerHandler().run();
}