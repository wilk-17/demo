package com.example.demo.controller;

import com.example.demo.model.State;
import com.example.demo.repository.StateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/state")
public class StateController {

    @Autowired
    private StateRepository stateRepository;

    @GetMapping
    public ResponseEntity<List<State>> getAll() {
        List<State> states = stateRepository.findAll();
        return ResponseEntity.ok(states);
    }

    @GetMapping("/{id}")
    public ResponseEntity<State> getById(@PathVariable Long id) {
        Optional<State> state = stateRepository.findById(id);
        return state.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }
}
