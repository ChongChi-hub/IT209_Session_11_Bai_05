package com.ptit.devops_ss11;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
class ApplicationTests {

    @Test
    void contextLoads() {
        assertTrue(true);
    }

    @Test
    void testBasicCalculation() {
        int expected = 10;
        int actual = 5 + 5;
        org.junit.jupiter.api.Assertions.assertEquals(expected, actual);
    }
}
