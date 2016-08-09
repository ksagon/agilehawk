package net.sagon.agile.repository;

import java.util.List;

import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;

public interface StoryRepo extends ModelRepo<Story> {

    List<Story> findByResolvedBy(Resource resolvedBy);

}
