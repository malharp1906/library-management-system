package com.example.library.repo;

import com.example.library.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
public interface BookRepo extends JpaRepository<Book, Long> {

}

