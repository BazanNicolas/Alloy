sig Addr, Data {}

sig Memory {
 	addrs: set Addr,
 	map: addrs -> one Data
 }

sig MainMemory extends Memory { }
sig Cache extends Memory {
 	dirty: set addrs
 }

sig System {
 	cache: Cache,
	main: MainMemory
 }{
    cache.addrs in main.addrs
}

pred Write [m_i,m_o: Memory, d: Data, a: Addr] {
 	m_o.map = m_i.map ++ (a -> d)
 }

pred Flushing [s_i, s_o: System]{
	s_o.cache.dirty = none
    s_o.cache.map = s_i.cache.map
	s_o.main.map =  s_i.main.map ++ s_i.cache.map
}

pred Loading [s_i, s_o: System,  a: Addr] {
	s_o.cache.map = s_i.cache.map ++ (a -> s_i.main.map[a])
    s_o.cache.dirty = s_i.cache.dirty - a
    s_o.main = s_i.main
}

pred Consistent [s:System] {
	s.cache.map - (s.cache.dirty -> Data) in s.main.map
}

assert FlushConsistent {
    all s_i,s_o:System | (Consistent[s_i] && Flushing[s_i, s_o]) implies Consistent[s_o]
}

assert LoadConsistent {
    all s_i,s_o:System, a:Addr | (Consistent[s_i] && Loading[s_i, s_o, a]) implies Consistent[s_o]
}

check FlushConsistent for 3 but 2 System
check LoadConsistent for 3 but 2 System
