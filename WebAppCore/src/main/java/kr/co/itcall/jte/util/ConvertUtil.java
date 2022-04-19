package kr.co.itcall.jte.util;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ConvertUtil<T> {

	private static final ObjectMapper OBJECT_MAPPER;
	static { OBJECT_MAPPER = new ObjectMapper(); }
	
	public T readFromJson(String jsonInput, Class<T> clazz) {
		try {
			return OBJECT_MAPPER.readValue(jsonInput, new TypeReference<T>() {});
		} catch (IOException e) {
			log.error("parsing error messge[{}], cause[{}] [return null] ::: jsonInput[{}] >>> Class[{}]", e.getMessage(), e.getCause(), jsonInput, clazz);
		}
		return null;
	}

	public String readFromObj(T objInput) {
		try {
			return OBJECT_MAPPER.writeValueAsString(objInput);
		} catch (JsonProcessingException e) {
			log.error("parsing error messge[{}], cause[{}] [return \"\"] ::: objInput[{}]", e.getMessage(), e.getCause(), objInput);
		}
		return "";
	}

	public List<T> readListFromJson(String jsonInput, Class<T> clazz) {
		try {
			return OBJECT_MAPPER.readValue(jsonInput, new TypeReference<List<T>>() {});
		} catch (IOException e) {
			log.error("parsing error messge[{}], cause[{}] [return null] ::: jsonInput[{}] >>> Class[{}]", e.getMessage(), e.getCause(), jsonInput, clazz);
		}
		return null;
	}

	public String readFromList(List<T> listInput) {
		try {
			return OBJECT_MAPPER.writeValueAsString(listInput);
		} catch (JsonProcessingException e) {
			log.error("parsing error messge[{}], cause[{}] [return \"\"] ::: listInput[{}]", e.getMessage(), e.getCause(), listInput);
		}
		return "";
	}

}
