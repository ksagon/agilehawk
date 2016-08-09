package net.sagon.agile.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.BinaryOperator;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.sagon.agile.dto.FormResponse;
import net.sagon.agile.model.IssueLoader;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Team;
import net.sagon.agile.service.ResourceService;
import net.sagon.agile.service.TeamService;

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
import org.springframework.web.multipart.MultipartFile;

@Controller
public class TeamController {
    @Autowired
    private IssueLoader loader;

    @Autowired
    private TeamService teamService;
    
    @Autowired
    private ResourceService resourceService;

    @RequestMapping(value="/teams", method=RequestMethod.GET)
    public String getTeams(ModelMap model, HttpServletRequest request) {
        Iterable<Team> teams = teamService.findAll();

        model.addAttribute("teams", teams);

        return "teams";
    }

    @RequestMapping(value="/team", method=RequestMethod.GET)
	public String getTeam(ModelMap model, HttpServletRequest request, @Valid AnalysisDates analysisDates) {
	    Team t = getTeam();

	    if( analysisDates.getStart() != null && analysisDates.getEnd() != null ) {
	        t.setStart(analysisDates.getStart());
	        t.setEnd(analysisDates.getEnd());
	    }

        model.addAttribute("team", t);

        return "team";
	}

    @RequestMapping(value="/team/{id}", method=RequestMethod.GET)
    public String getTeam(ModelMap model, @PathVariable String id, HttpServletRequest request) {
        Team t = teamService.find(id);

        model.addAttribute("team", t);
        model.addAttribute("resources", getResourcesNotOnTeam(id));

        return "team";
    }

    @RequestMapping(value="/teamDetails/{id}", method=RequestMethod.GET)
    public String teamDetails(@PathVariable String id, ModelMap model) {
        Team team = teamService.find(id);
        model.addAttribute("team", team);

        return "teamDetails";
    }

    @RequestMapping(value="/team/action/delete")
    public String deleteTeam(@RequestParam final String modalId, @RequestParam final String id, final ModelMap model) {
        Team team = teamService.find(id);
        
        model.addAttribute("modalId", modalId);
        model.addAttribute("team", team);

        return "teamDelete";
    }

    @RequestMapping(value="/team/{id}", method=RequestMethod.DELETE)
    @ResponseBody
    public FormResponse deleteTeam(@PathVariable String id) {
        teamService.delete(id);

        return new FormResponse();
    }

    @RequestMapping(value="/team/{id}/resource", method=RequestMethod.POST)
    @ResponseBody
    public FormResponse addResource(@PathVariable String id, @Valid @ModelAttribute("resource") Resource resource, final BindingResult bindingResult) {
        Team team = teamService.find(id);
        if( team != null ) {
            team.addResource(resource);
            teamService.save(team);
        }

        return new FormResponse(bindingResult);
    }

    @RequestMapping(value="/team/{id}/resource/{resourceId}", method=RequestMethod.POST)
    public void addResource(@PathVariable String id, @PathVariable String resourceId) {
        Team team = teamService.find(id);
        Resource resource = resourceService.find(resourceId);

        if( team != null && resource != null ) {
            team.addResource(resource);
            teamService.save(team);
        }
    }

    @RequestMapping(value="/teamDetails", method=RequestMethod.GET)
    public String teamDetails(ModelMap model) {
        Team team = new Team();
        model.addAttribute("team", team);

        return "teamDetails";
    }

    @RequestMapping(value="/team", method=RequestMethod.POST)
    @ResponseBody
    public FormResponse saveTeam(@Valid @ModelAttribute("team") Team team, final BindingResult bindingResult) {
        if( !bindingResult.hasErrors() ) {
            teamService.save(team);
        }

        return new FormResponse(bindingResult);
    }

    private Team getTeam() {
	    loader.loadFromRepo();

        return loader.getTeam();
    }

    @RequestMapping(value="/issue/load", method=RequestMethod.POST)
	public String loadIssues(ModelMap model,
			@RequestParam("issues") MultipartFile issues, HttpServletRequest request) {
		if( !issues.isEmpty() ) {
			try( InputStream issueStream = issues.getInputStream() ) {
				Reader r = new InputStreamReader(issueStream);
				loadIssues(r);
			}
			catch(IOException e) {
				e.printStackTrace();
			}
		}

		return "redirect:/agile/team";
	}

    @RequestMapping(value="/team/{teamId}/resource/{resourceId}", method=RequestMethod.DELETE)
    @ResponseBody
    public FormResponse deleteResource(@PathVariable String teamId, @PathVariable String resourceId) {
        teamService.removeResource(teamId, resourceId);

        return new FormResponse();
    }

    @RequestMapping(value="/team/{teamId}/resource/{resourceId}/action/delete")
    public String deleteResource(@RequestParam final String modalId, @PathVariable final String teamId, @PathVariable final String resourceId, final ModelMap model) {
        Team team = teamService.find(teamId);
        Resource resource = team.getResource(resourceId);
        
        model.addAttribute("modalId", modalId);
        model.addAttribute("team", team);
        model.addAttribute("resource", resource);

        return "teamResourceDelete";
    }

    @RequestMapping(path="/team/{teamId}/resource", params={"filter=eligible"})
    @ResponseBody
    public Map<String, String> getResourcesNotOnTeam(@PathVariable String teamId) {
        Team team = teamService.find(teamId);

        List<Resource> resources = resourceService.findAll();
        if( team != null ) {
            resources.removeAll(team.getResources());
        }

        return resources.stream().collect(Collectors.toMap(Resource::getName, r -> r.getId(), (k,v) -> {return v;}, TreeMap::new));
    }

    private void loadIssues(Reader issues) throws IOException {
		loader.load(issues);
		loader.clearRepo();
		loader.persist();
	}
}
