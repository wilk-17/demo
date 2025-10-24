package com.example.demo.controller;

import com.example.demo.model.Person;
import com.example.demo.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/person")
public class PersonController {

    @Autowired
    private PersonRepository personRepository;

    @GetMapping
    public ResponseEntity<List<Person>> getAllPersons() {
        List<Person> persons = personRepository.findAll();
        return ResponseEntity.ok(persons);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Person> getPersonById(@PathVariable Long id) {
        Optional<Person> person = personRepository.findById(id);
        return person.map(ResponseEntity::ok)
                    .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/dni/{dni}")
    public ResponseEntity<Person> getPersonByDni(@PathVariable String dni) {
        Optional<Person> person = personRepository.findByDni(dni);
        return person.map(ResponseEntity::ok)
                    .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Person> createPerson(@RequestBody Person person) {
        if (person.getDni() != null && personRepository.existsByDni(person.getDni())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
        Person savedPerson = personRepository.save(person);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedPerson);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Person> updatePerson(@PathVariable Long id, @RequestBody Person personDetails) {
        Optional<Person> personOptional = personRepository.findById(id);
        
        if (personOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Person person = personOptional.get();
        person.setDni(personDetails.getDni());
        person.setFirstName(personDetails.getFirstName());
        person.setLastName(personDetails.getLastName());
        person.setAddress(personDetails.getAddress());
        person.setPhone(personDetails.getPhone());
        person.setCityId(personDetails.getCityId());

        Person updatedPerson = personRepository.save(person);
        return ResponseEntity.ok(updatedPerson);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePerson(@PathVariable Long id) {
        if (!personRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        personRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
