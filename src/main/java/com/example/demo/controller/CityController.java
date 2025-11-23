package com.example.demo.controller;

import com.example.demo.model.City;
import com.example.demo.repository.CityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/cities")
public class CityController {

    @Autowired
    private CityRepository cityRepository;

    @PreAuthorize("hasAuthority('READ_CITIES')")
    @GetMapping
    public ResponseEntity<List<City>> getAllCities() {
        List<City> cities = cityRepository.findAll();
        return ResponseEntity.ok(cities);
    }

    @PreAuthorize("hasAuthority('READ_CITIES')")
    @GetMapping("/{id}")
    public ResponseEntity<City> getCityById(@PathVariable Long id) {
        Optional<City> city = cityRepository.findById(id);
        return city.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_CITIES')")
    @GetMapping("/code/{code}")
    public ResponseEntity<City> getCityByCode(@PathVariable String code) {
        Optional<City> city = cityRepository.findByCode(code);
        return city.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_CITIES')")
    @GetMapping("/state/{stateId}")
    public ResponseEntity<List<City>> getCitiesByState(@PathVariable Long stateId) {
        List<City> cities = cityRepository.findByStateId(stateId);
        return ResponseEntity.ok(cities);
    }

    @PreAuthorize("hasAuthority('WRITE_CITIES')")
    @PostMapping
    public ResponseEntity<City> createCity(@RequestBody City city) {
        City savedCity = cityRepository.save(city);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedCity);
    }

    @PreAuthorize("hasAuthority('WRITE_CITIES')")
    @PutMapping("/{id}")
    public ResponseEntity<City> updateCity(@PathVariable Long id, @RequestBody City cityDetails) {
        Optional<City> cityOptional = cityRepository.findById(id);
        
        if (cityOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        City city = cityOptional.get();
        city.setDescription(cityDetails.getDescription());
        city.setCode(cityDetails.getCode());
        city.setStateId(cityDetails.getStateId());

        City updatedCity = cityRepository.save(city);
        return ResponseEntity.ok(updatedCity);
    }

    @PreAuthorize("hasAuthority('DELETE_CITIES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCity(@PathVariable Long id) {
        if (!cityRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        cityRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
