package net.sagon.agile.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.sagon.agile.dto.FormResponse;
import net.sagon.agile.model.Resource;
import net.sagon.agile.service.ResourceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ResourceController {
    @Autowired
    private ResourceService resourceService;

    @RequestMapping(value="/resources", method=RequestMethod.GET)
    public String getResources(ModelMap model, HttpServletRequest request) {
        List<Resource> resources = resourceService.findAll();

        model.addAttribute("resources", resources);

        return "resources";
    }

    @RequestMapping(value="/resource/{id}", method=RequestMethod.GET)
    public String getResource(@PathVariable String id, ModelMap model, HttpServletRequest request) {
        Resource resource = resourceService.find(id);

        model.put("resource", resource);

        return "resource";
    }

    @RequestMapping(value="/resourceDetails", method=RequestMethod.GET)
    public String resourceDetails(ModelMap model) {
        Resource resource = new Resource();
        model.addAttribute("resource", resource);

        return "resourceDetails";
    }

    @RequestMapping(value="/resourceDetails/{id}", method=RequestMethod.GET)
    public String resourceDetails(@PathVariable String id, ModelMap model) {
        Resource resource = resourceService.find(id);
        model.addAttribute("resource", resource);

        return "resourceDetails";
    }

    @RequestMapping(value="/resource", method=RequestMethod.POST)
    @ResponseBody
    public FormResponse saveResource(@Valid @ModelAttribute("resource") Resource resource, final BindingResult bindingResult) {
        if( !bindingResult.hasErrors() ) {
            resourceService.save(resource);
        }

        return new FormResponse(bindingResult);
    }

    @RequestMapping(value="/resource/{id}", method=RequestMethod.DELETE)
    @ResponseBody
    public FormResponse deleteResource(@PathVariable String id) {
        resourceService.delete(id);

        return new FormResponse();
    }

    @RequestMapping(value="/resource/action/delete")
    public String deleteResource(@RequestParam final String modalId, @RequestParam final String id, final ModelMap model) {
        Resource resource = resourceService.find(id);
        
        model.addAttribute("modalId", modalId);
        model.addAttribute("resource", resource);

        return "resourceDelete";
    }


}
