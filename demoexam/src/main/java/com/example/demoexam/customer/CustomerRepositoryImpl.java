package com.example.demoexam.customer;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Primary
@Repository
public class CustomerRepositoryImpl implements CustomerRepository {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void create(Map<String, Object> map) {
		sqlSessionTemplate.insert("customer.create", map);

	}

	@Override
	public List<Customer> readlist() {

		return sqlSessionTemplate.selectList("customer.readlist");
	}

	@Override
	public Customer readdetail(String username) {
		
		return sqlSessionTemplate.selectOne("customer.readdetail",username );
	}

	@Override
	public void update(Map<String, Object> map) {
		sqlSessionTemplate.update("customer.update", map);

	}

	@Override
	public void delete(String username) {
		sqlSessionTemplate.delete("customer.delete",username);

	}

}
