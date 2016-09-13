package net.sagon.agile.controller.rest;

import javax.validation.Valid;

import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.PagedResources;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import net.sagon.agile.dto.ModelResource;
import net.sagon.agile.model.Model;

public interface ModelAPIController<R extends ModelResource<?>, M extends Model> {
    PagedResources<R> get(@PageableDefault(page=0, size=5) Pageable pageable, PagedResourcesAssembler<M> assembler );

    R get( @PathVariable final String id );

    R update( @PathVariable final String id, @Valid @RequestBody M model );

    R create( @Valid @RequestBody M model );

    R delete( @PathVariable final String id );
}
