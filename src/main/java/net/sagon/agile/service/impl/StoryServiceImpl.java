package net.sagon.agile.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;
import net.sagon.agile.repository.StoryRepo;
import net.sagon.agile.service.StoryService;

@Service
public class StoryServiceImpl extends ModelServiceImpl<Story> implements StoryService {

	@Autowired
	private StoryRepo repo;

	@Override
	public StoryRepo getRepo() {
		return repo;
	}

	@Override
	public List<Story> findByResolvedBy(Resource resolvedBy) {
		return repo.findByResolvedBy(resolvedBy);
	}

}
