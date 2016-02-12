package net.sagon.agilecoach.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;

import net.sagon.agilecoach.model.IssueLoader;
import net.sagon.agilecoach.model.Team;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class TeamController {

	@RequestMapping("/team")
	public String getTeam(ModelMap model, HttpServletRequest request) {
		try {
			Team team = getTeam(request);

			model.addAttribute("team", team);
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return "team";
	}

	private Team getTeam(HttpServletRequest request) {
		return (Team) request.getSession().getAttribute("team");
	}

	@RequestMapping(value="/team/load", method=RequestMethod.POST)
	public String loadTeam(@RequestParam("issues") MultipartFile issues, HttpServletRequest request) {
		if( !issues.isEmpty() ) {
			try( InputStream issueStream = issues.getInputStream() ) {
				Reader r = new InputStreamReader(issueStream);
				loadTeam(r, request);
			}
			catch(IOException e) {
				e.printStackTrace();
			}
		}

		return "team";
	}

	private void loadTeam(Reader issues, HttpServletRequest request) throws IOException {
		IssueLoader loader = new IssueLoader();
		loader.load(issues);

		request.setAttribute("team", loader.getTeam());
	}

}
