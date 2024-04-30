package com.team6.member.model;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MemberService {

	@Autowired
	private MemberRepository repository;
	
	@Autowired
	private BossAcconutRepository bossRepository;
	
	// 登入
	public BossAccountBean login(String account,String pwd) {
		Optional<BossAccountBean> optional =bossRepository.login(account, pwd);
		if(!optional.isEmpty()) {
			return optional.get();
		}
		return null;
	}

	// 查詢單筆
	public MemberBean findById(String account) {
		Optional<MemberBean> optional = repository.findById(account);
		if (!optional.isEmpty()) {
			return optional.get();
		}
		return null;
	}
	
	// 模糊查詢
	public List<MemberBean> findByName(String name) {
		return repository.findBymName(name);
	}

	// 全部查詢
	public List<MemberBean> findAll() {
		return repository.findAll();
	}

	// 回傳模糊搜尋頁面筆數
	/*public Page<MemberBean> findByNameByPage(Pageable pageable,String name) {
		List<MemberBean>beans=repository.findBymName(name);
		Page<MemberBean> page = new Page<MemberBean>() {
			
			@Override
			public Iterator<MemberBean> iterator() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Pageable previousPageable() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Pageable nextPageable() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public boolean isLast() {
				// TODO Auto-generated method stub
				return false;
			}
			
			@Override
			public boolean isFirst() {
				// TODO Auto-generated method stub
				return false;
			}
			
			@Override
			public boolean hasPrevious() {
				// TODO Auto-generated method stub
				return false;
			}
			
			@Override
			public boolean hasNext() {
				// TODO Auto-generated method stub
				return false;
			}
			
			@Override
			public boolean hasContent() {
				// TODO Auto-generated method stub
				return false;
			}
			
			@Override
			public Sort getSort() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public int getSize() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public int getNumberOfElements() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public int getNumber() {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public List<MemberBean> getContent() {
				return repository.findBymNameByPage(name, pageable.getPageNumber(), pageable.getPageSize());
			}
			
			@Override
			public <U> Page<U> map(Function<? super MemberBean, ? extends U> converter) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public int getTotalPages() {
				// TODO Auto-generated method stub
				return beans.size()/pageable.getPageSize();
			}
			
			@Override
			public long getTotalElements() {
				// TODO Auto-generated method stub
				return beans.size();
			}
		};
		return page;
	}*/
	
	// 回傳搜尋頁面筆數
		public Page<MemberBean> findAllByPage(Pageable pageable) {
			return repository.findAll(pageable);
		}

	// 新增
	public MemberBean insert(MemberBean bean) {
		Optional<MemberBean> optional = repository.findById(bean.getAccount());
		if (optional.isEmpty()) {
			return repository.save(bean);
		}
		return null;
	}

	// 更新
	public MemberBean update(MemberBean bean) {
		Optional<MemberBean> optional = repository.findById(bean.getAccount());
		if (!optional.isEmpty()) {
			return repository.save(bean);
		}
		return null;
	}

	// 更新權限
	public boolean updateToPermissions(String acconut, int permissions) {
		Optional<MemberBean> optional = repository.findById(acconut);
		if (!optional.isEmpty()) {
			MemberBean bean = optional.get();
			bean.setPermissions(permissions);
			repository.save(bean);
			return true;
		}
		return false;
	}
	
	// 刪除
	public boolean delete(String account) {
		Optional<MemberBean> optional=repository.findById(account);
		if (!optional.isEmpty()) {
			repository.delete(optional.get());
			return true;
		}
		return false;
	}
	
	// 存檔 CSV
	public void saveToCSV() {
		String file = "C:\\Users\\User\\Downloads\\newMember.csv";
		String csv = "account,mName,password,mEmail,mPhone,birthday,permissions\n";
		List<MemberBean> beans =repository.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberBean bean : beans) {
				csv += bean.saveToCsv()+"\n";
			}
			byte[] bytes = csv.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}
	// 存檔 XML
	public void saveToXML() {
		String file = "C:\\Users\\User\\Downloads\\newMember.xml";
		String xml="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+"\n"+"<Root>"+"\n";
		List<MemberBean> beans =repository.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberBean bean : beans) {
				xml += bean.saveToXml();
			}
			xml +="</Root>";
			byte[] bytes = xml.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}
	// 存檔 JSON
	public void saveToJSON() {
		String file = "C:\\Users\\User\\Downloads\\newMember.json";
		String json= "[";
		List<MemberBean> beans =repository.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberBean bean : beans) {
				json += bean.saveToJson()+"\n";
			}
			json=json.substring(0, json.length()-2)+"\n]";
			byte[] bytes = json.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}
}
