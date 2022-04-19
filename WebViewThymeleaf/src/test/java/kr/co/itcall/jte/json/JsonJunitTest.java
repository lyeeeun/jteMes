package kr.co.itcall.jte.json;

import static org.junit.Assert.assertThat;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import org.hamcrest.core.IsEqual;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.json.JacksonTester;
import org.springframework.boot.test.json.JsonContent;
import org.springframework.boot.test.json.ObjectContent;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
@RunWith(SpringRunner.class)
//@Import(TestConfig.class)
@SpringBootApplication(scanBasePackages = {"kr.co.itcall.jte"})
//@JsonTest
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@ActiveProfiles("local")
public class JsonJunitTest {

//	@Autowired
//	private JacksonTester<Article> json;
//
//	@Before
//	public void setup() {
//		ObjectMapper objectMapper = new ObjectMapper();
//		JacksonTester.initFields(this, objectMapper);
//	}
//
//	@Test
//	public void testSerialize() throws IOException {
//		Article article = new Article(1, "kwseo", "good", "good article", Timestamp.valueOf((LocalDateTime.now())));
//
//		// assertThat(json.write(article)).isEqualToJson("expected.json"); 직접 파일과 비교
//		// assertThat(json.write(article)).hasJsonPathStringValue("@.author");
//		// assertThat(json.write(article)).extractingJsonPathStringValue("@.title").isEqualTo("good");
//		JsonContent<Article> contents = json.write(article);
//		log.debug("JsonContents = [{}]", contents);
//	}
//
//	@Test
//	public void testDeserialize() throws IOException {
//		Article article = new Article(1, "kwseo", "good", "good article", new Timestamp(1499655600000L));
//		String jsonString = "{\"id\": 1, \"author\": \"kwseo\", \"title\": \"good\", \"content\": \"good article\", \"createdDate\": 1499655600000}";
//
//		ObjectContent<Article> content = json.parse(jsonString);
//		log.debug("json.parse(jsonString) = [{}]", content );
//		Article articleParse = json.parseObject(jsonString);
//		log.debug("json.parseObject(jsonString) = [{}]", articleParse );
//
//		assertThat(json.parse(jsonString), IsEqual.equalTo(article));
//		assertThat(json.parseObject(jsonString).getAuthor(), IsEqual.equalTo("kwseo"));
//
//	}

}
