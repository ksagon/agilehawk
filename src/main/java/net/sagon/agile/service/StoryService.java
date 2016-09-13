package net.sagon.agile.service;

import java.util.List;

import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;

public interface StoryService extends ModelService<Story> {

	List<Story> findByResolvedBy(Resource resolvedBy);
}
