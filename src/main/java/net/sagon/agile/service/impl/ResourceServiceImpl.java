package net.sagon.agile.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.sagon.agile.model.Resource;
import net.sagon.agile.repository.ModelRepo;
import net.sagon.agile.repository.ResourceRepo;
import net.sagon.agile.service.ResourceService;

@Service
public class ResourceServiceImpl extends ModelServiceImpl<Resource> implements ResourceService {
    
    @Autowired
    private ResourceRepo repo;

    @Override
    public ModelRepo<Resource> getRepo() {
    	return repo;
    }

}
