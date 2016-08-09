package net.sagon.agile.repository;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import net.sagon.agile.model.Model;

public interface ModelRepo<M extends Model> extends PagingAndSortingRepository<M, String> {

	List<M> findByName(String name);

}
