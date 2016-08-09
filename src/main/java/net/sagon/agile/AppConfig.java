package net.sagon.agile;

import java.net.UnknownHostException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mongodb.MongoClient;

@Configuration
public class AppConfig {

    public @Bean MongoClient mongo() throws UnknownHostException {
        return new MongoClient("localhost", 27017);
    }
}
