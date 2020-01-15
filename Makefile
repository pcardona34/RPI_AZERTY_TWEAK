EXEC=rpiazertytweak

all:
	chmod 755 DEBIAN/postinst
	chmod 755 DEBIAN/prerm
	cd .. && dpkg-deb --build $(EXEC)

install: ../$(EXEC).deb
	cd .. && sudo dpkg -i $(EXEC).deb


clean:
	cd .. && rm $(EXEC).deb

