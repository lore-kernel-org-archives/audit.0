Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C05338D;
	Tue, 27 Feb 2024 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016547; cv=none; b=PBEybdXu0oJlaDwFBi0cTbh9Ytikt2p82eGI12iGgaQo8caNOsj6RemRolHzkX21SqobrOG5gJKrTVdz3nvYpssIPhNIl8/4AsF8b8QPtLBAPddZ4x5NJmTTUol3Gw0PU2JvSX40u3WHMYtQI2pKcHcfEcwSoce0erertsjcbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016547; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:Content-type; b=A6lPiznI2Dksi6Hvyb4J3kAR8DHjAsVged9NI2YWz+JhYP0FOwvL1uhNoTvMbFoAgkLp4T1S1JNvjODahp36le1i4FrLfgLXqP5gluTI0aOY2z6VkwLNSpJ99M/PM8ic/MJF423W0soc8or+D7iN+hH+KorWofG0WkHgwHBWS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=zZ/qpfHe; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="zZ/qpfHe"
Received: from [192.168.1.94] (45-23-117-7.lightspeed.livnmi.sbcglobal.net [45.23.117.7])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 41R6n3KT032147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Feb 2024 22:49:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1709016545; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:From:Subject;
	b=zZ/qpfHeNWmFWTnKgj/cKesD9r+tHMwdt2jSyzjghEWZjqsXK0xYUUDyFVsTJP0vu
	 0fOUZ5owS3k7eTcU9fZpqHPhE90tttngoVy/W1ijTmu6eMYvbVMdzGTcaVIXwWvQu0
	 PQ/XgHKenR0v2OHFFEtikCXELYFmQ9gYgfJRmL6trYfD3X6zvMzFT/cTii+K/bknTL
	 BEHwQLCh31qr+9bLH0a5Gb/pFpVP0p92NY7+4flZDueuDSgApg8K5ZUZNBG+ysXKb4
	 9zCV9iI199eRjxXXO1XYZJycAWucS7FZoimT0aLksdwzFNnrAbLUow1HRGD7/vNwP8
	 MMsG2PtF1fPHw==
From: delyan@sonic.net
To: audit+subscribe@vger.kernel.org, audit+unsubscribe@vger.kernel.org,
        audit@vger.kernel.org, autofs+subscribe@vger.kernel.org,
        autofs+unsubscribe@vger.kernel.org
Date: Tue, 27 Feb 2024 01:49:02 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: subscribe
Message-ID: <65DD85DE.5026.445CAE22@delyan.sonic.net>
Priority: normal
X-mailer: Pegasus Mail for Windows (4.80.1028)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Sonic-CAuth: UmFuZG9tSVbSWaep/LDGPpc+nI0FeQIuPLglF7WRFV0HpRihW4o/3xQFIbKP1hKnS4HdYoO+zMpqtGQZgjbB2rPj9UtgMter
X-Sonic-ID: C;zAMzSzzV7hGMWLYCP63e0g== M;jvQfTDzV7hGMWLYCP63e0g==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

subscribe
