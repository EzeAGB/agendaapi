package edu.galileo.agenda.controller;

import edu.galileo.agenda.model.Contacto;
import edu.galileo.agenda.service.ContactoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/contacto")
public class ContactoController {

    public ContactoController(ContactoService contactoService) {
        this.contactoService = contactoService;
    }

    @GetMapping
    public List<Contacto> getAll() {
        return this.contactoService.list();
    }

    @PostMapping
    public Contacto add(@RequestBody(required = true) Contacto contacto) {
        return this.contactoService.add(contacto);
    }

    private final ContactoService contactoService;
}
