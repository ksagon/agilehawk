package net.sagon.agilecoach.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;

import net.sagon.agilecoach.model.IssueLoader;
import net.sagon.agilecoach.model.Team;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class TeamController {

	@RequestMapping(value="/team", method=RequestMethod.GET)
	public String getTeam(ModelMap model, HttpServletRequest request) {
		return "team";
	}

	@RequestMapping(value="/team/load", method=RequestMethod.POST)
	public String loadTeam(ModelMap model, 
			@RequestParam("start") @DateTimeFormat(iso = ISO.DATE) LocalDate start, 
			@RequestParam("end") @DateTimeFormat(iso = ISO.DATE) LocalDate end, 
			@RequestParam("issues") MultipartFile issues, HttpServletRequest request) {
		if( !issues.isEmpty() ) {
			try( InputStream issueStream = issues.getInputStream() ) {
				Reader r = new InputStreamReader(issueStream);
				model.addAttribute("team", loadTeam(r, start, end));
			}
			catch(IOException e) {
				e.printStackTrace();
			}
		}

		return "team";
	}

	private Team loadTeam(Reader issues, LocalDate start, LocalDate end) throws IOException {
		IssueLoader loader = new IssueLoader();
		loader.load(issues);

		Team t = loader.getTeam();
		t.setStart(start);
		t.setEnd(end);

		return t;
	}

}
