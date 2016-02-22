package net.sagon.agilecoach.repository;

import net.sagon.agilecoach.model.Resource;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface ResourceRepo extends MongoRepository<Resource, String> {

}
