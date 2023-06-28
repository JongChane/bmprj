package dto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.VisitDao;

@Service
public class ViService {
	@Autowired
	private VisitDao visitDao;
}
