package net.sagon.agile.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import net.sagon.agile.model.Model;
import net.sagon.agile.model.Resource;
import net.sagon.agile.service.ModelService;

@Service
public abstract class ModelServiceImpl<M extends Model> implements ModelService<M> {
    private final static Logger LOG = LoggerFactory.getLogger(ModelServiceImpl.class);

    @Override
    public M find(String id) {
        return getRepo().findOne(id);
    }

    @Override
    public M findByName(String name) {
    	List<M> models = getRepo().findByName(name);

    	return models.stream().findFirst().orElse(null);
    }

    @Override
    public void save(M model) {
    	getRepo().save(model);
    }

    @Override
    public void save(List<M> models) {
    	getRepo().save(models);
    }

    @Override
    public List<M> findAll() {
    	List<M> models = new ArrayList<>();
    	getRepo().findAll().forEach( m -> models.add(m) );

    	return models;
    }

    @Override
    public Page<M> findAll(Pageable pageable) {
    	return getRepo().findAll(pageable);
    }

    @Override
    public void delete(String id) {
    	getRepo().delete(id);
    }
}
