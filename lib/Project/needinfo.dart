class needinfo {
  String thisid;
  String id; //需求单id
  String yorn;
  String personid; //公司ID
  // String name; //用户名称
  // String info; //公司信息
  // String tel; //公司的电话
  // String address; //公司的地址
  // String email; //公司的邮箱
  // String company; //公司名称

  // needinfo(int id, String personid, String name, String info, String tel,
  //     String address, String email, String company) {
  //   this.id = id; //需求单id
  //   this.personid = personid; //公司ID
  //   this.name = name; //用户名称
  //   this.info = info; //公司信息
  //   this.tel = tel; //公司的电话
  //   this.address = address; //公司的地址
  //   this.email = email; //公司的邮箱
  //   this.company = company; //公司名称
  // }

  needinfo(String personid, String thisid, String id, String yorn) {
    this.personid = personid; //公司ID
    this.thisid = thisid; //需求单序号
    this.id = id; //需求单真实id
    this.yorn = yorn;
  }
}
