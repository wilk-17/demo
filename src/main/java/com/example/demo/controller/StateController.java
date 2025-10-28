package com.example.demo.controller;

import com.example.demo.model.State;
import com.example.demo.repository.StateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

    @PostMapping
    public ResponseEntity<State> createState(@RequestBody State state) {
        try {
            State savedState = stateRepository.save(state);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedState);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<State> updateState(@PathVariable Long id, @RequestBody State stateDetails) {
        Optional<State> stateOptional = stateRepository.findById(id);
        
        if (stateOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        State state = stateOptional.get();
        state.setDescription(stateDetails.getDescription());
        state.setCode(stateDetails.getCode());

        State updatedState = stateRepository.save(state);
        return ResponseEntity.ok(updatedState);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteState(@PathVariable Long id) {
        if (!stateRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        stateRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
