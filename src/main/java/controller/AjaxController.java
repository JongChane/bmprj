package controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dto.ViService;


@RestController
@RequestMapping("ajax")
public class AjaxController {
	@Autowired
	ViService service;
	
    @RequestMapping("graph1")
    public ResponseEntity<List<Map<String, Object>>> graph1(String id) {
        List<Map<String, Object>> data = service.data(id);
        return ResponseEntity.ok(data);
    }
	
}
