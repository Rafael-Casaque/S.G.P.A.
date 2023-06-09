package com.example.sgpa.domain.usecases.report;

import java.time.LocalDateTime;
import java.util.List;

import com.example.sgpa.domain.entities.checkout.CheckedOutItem;
import com.example.sgpa.domain.entities.historical.Event;
import com.example.sgpa.domain.usecases.checkout.CheckedOutItemDAO;
import com.example.sgpa.domain.usecases.historical.EventDAO;
import com.example.sgpa.domain.usecases.part.PartItemDAO;
import com.example.sgpa.domain.usecases.utils.validation.CheckExistencePartUseCase;
import com.example.sgpa.domain.usecases.utils.validation.DateType;
import com.example.sgpa.domain.usecases.utils.validation.VerifyDateUseCase;

public class GenerateReportByPartUseCase {
	private final EventDAO eventDAO;
	private final PartItemDAO partItemDAO;
	public GenerateReportByPartUseCase(EventDAO eventDAO, PartItemDAO partItemDAO) {
		this.eventDAO = eventDAO;
		this.partItemDAO = partItemDAO;
	}
	public List<Event> generate(int patrimonialId, LocalDateTime start, LocalDateTime end) throws  Exception{
		CheckExistencePartUseCase checkExistencePartUseCase = new CheckExistencePartUseCase(partItemDAO);
		checkExistencePartUseCase.check(patrimonialId);
		VerifyDateUseCase.verify(DateType.START, start);
		VerifyDateUseCase.verify(DateType.END, end);
		List<Event> eventList = eventDAO.getReportByPart(patrimonialId, start, end);
		if(eventList.isEmpty())
			throw new RuntimeException("data not found for the informed parameters");
		return eventList;
	}
}
