package polymorphism;

public  class LgTV implements TV {
	
	public LgTV() {
		System.out.println("===> LgTV 객체 생성");
	}

	@Override
	public void powerOn() {
		System.out.println("LgTV---전원 켠다.");
		
	}

	@Override
	public void powerOff() {
		System.out.println("LgTV---전원 끈다.");
		
	}

	@Override
	public void volumeUp() {
		System.out.println("LgTV---소리 울린다.");
		
	}

	@Override
	public void volumeDown() {
		System.out.println("LgTV---소리 내린다.");
		
	}

}
