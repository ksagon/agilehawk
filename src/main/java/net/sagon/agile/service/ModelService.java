package net.sagon.agile.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import net.sagon.agile.model.Model;
import net.sagon.agile.repository.ModelRepo;

public interface ModelService<M extends Model> {
	ModelRepo<M> getRepo();

	M find(String id);
	M findByName(String name);

    void save(M model);

    void save(List<M> models);

    List<M> findAll();
    Page<M> findAll(Pageable pageable);

    void delete(String id);

}
