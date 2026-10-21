Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592814;
	b=3Ur7lfMAZBpWTWg6LEYdsWq6wG2f0ggbYVyMmhBL1kUowMiYNXc0WK73GW5HCPA0GYa8
	 /9PTl9F61xSKRDc20fPcwWZNVb4DJbyLvBWMk0iaWEcqBhd4uezgky+6fgp+shPWTTGsw
	 feaaG93TQeTrB8mwOEVvxfc1yoDONifEGMiObzG/Wi0gW/lZ8Se1Dw5jENbNYORuisYqB
	 dTuaR++zwDk+mj99ogEI2PSfwWaZx08Nopq+5gXPmK8/mX0x38DgkTIIw+V9wkIJ0w1bv
	 9Q7KcP6PyEaERQNKTl57aJjt+kcMvrVk5D06P49vOLUGn1O3a8I8aqypzg/0CAGcr2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
	b=bivc9uSt3uOWURI7Py8IbN67XjPcU6lftABLPpEbobH5a/2pGWQl2jb4JwiHHYKV6mF0
	 vE6aVc0bwOx9Jw1z9U3cEw2EQpnAew42dGpbqQH/x5FSiKl2Xb561wb5qcGAJqnhv6GrX
	 5jlkNz40md6Kl3zX8AAMPhmZiqBR0TnGPYIXiyFXYlQ7Sf9V87Kboa+Tv3tbEv9PVzTti
	 ufASmO6nq3tRkBr+wLKhllYgc13sPIIdvCCPQa5iWg5S362y1OCJaJ8o+SEU0IRaBFgzY
	 +Rgpw78J0lBF4qkVy3mV1cOr0ggRBe9/62nBrmZ/yl1x0EI+bKLMaivB25/s/1vAwrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B4606A324
	for <audit@vger.kernel.org>; Wed, 21 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F0B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c418e215671so100590966b.0
        for <audit@vger.kernel.org>; Wed, 21 Oct 2026 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592812; cv=none;
        d=google.com; s=arc-20260327;
        b=bpWXvvpeHG0vUdfmXVqBFrBmHEwchDcAytntJD/GtEbg7qgze6u2vl7frOVMavg0Er
         jAGSPJRI633C1ydcBrOWC+8+mKkTw0VSCzFWawFXbUf7DqY+uHN8Tz7rKhyRz3M2QN9c
         TRTbGfwO4UAKyYyecjD+ftIWuL4Hp4kcSTrfcdpevEUWmtxF374t3FTTp1ILYGy1qWgZ
         hPDBYVfdVtoditkNOLpiuSXFk8g6XJq3DvuwU9oelqxGaH+Ugil007nNtC9ohsRqgcS6
         nHM5rwMeL1nJm18bQWMBJIliYHFKaKdGdYv0euM/f0SvjmDshaxkmc/3lpxp8vjirjIM
         aggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        fh=0/JJPJ884rNS2EX8F2hGOFgk53otFrNkug/YIiXX9XA=;
        b=dWgkZkUn4pos4hPMzw05iKtX53+M1YLmBpMriigJZjUgMDOroqsIIYCnFwHy8XorP2
         k3bwyZurJXP7Q+3qnqWuwH3tEIzRqJ664Lt7c9AwPQqVWkyLxsNwlX+7OtRUMuCxv7eN
         jNYlK5IomFcKdrcDg9l4Kh7l3P0aRA41gLV4syyxhR691Bg2sFnDJukDuZlC9WwnFmoL
         /dw2KGS/w/iJWdO/xdbSLfX+XVrSJhzHek7qEirAqtqWUZ02WZ9A6DXz2HxNSYJSDwjV
         w0mO+3x60twKCg7GaKy8QXvq+qygw06cjMNLhC6dq1WYY13YJlAXhm5CTGkJOfX28FrB
         ML0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592812; x=1793197612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=BRqHAhOJRFQGCZ0436cerbXsvDGcjOTtcEFCOpJRV+nbVKbSAKMl662tBLFTfb2Sg5
         NFxQNyHoxxgYHQR13h13k71ankQp/N0fxgwfPZdFZZwD0LZwBvhOQiky2tnvBNcGVE92
         vpRJ7hzp6lhKrZveGyDGkQ94JZjS5rrim4/SQCOenhyqo5st97RuKWVFwTkWZQ5bTbIw
         iWX7FjROAHIvHplEaKREmJYGpSp7sUQFKLAPhXVjYlSpM8WQnUK4iSviJf2DCzgxJwf5
         mmlBS+ISZT3vDsrX9Xx3+f3KYgz6TnHUVdIwJP9bY9OfNIdfJdTh5lFsIo+qwhCRzOmH
         nAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592812; x=1793197612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=ix1SSzL3j/azwKP1mk1GdY0oxr1ZPN39dypxBwx/Xs4hiL+qHuEjPep8i7+iDlHJL3
         pypXThZn7WF8f0D9qh/Jwq6RgdLo0bXqX8rbb2XTt1ojjEnS12R85gDhFaspTks7EY7W
         z2rK9eNLzurWYywX4YGJa16h4BYnx2XBNI7wnQXEGoGQ82H1FHCu8S5Sta52awE1HmZo
         pdzbgG8+14K5YcFvWVSF7G/Jg6uwcAnxlvkNx+FMaX2EGpj85d8YBqeceiquZImr+WDO
         uln4IBeyNtx0V+vjUekSiGTJDtYFuipiobtKNwJYm/98D4hm95yaDihU3sThZCC9P+cP
         8/9g==
X-Forwarded-Encrypted: i=1; AKwUvBw/ccgA9a+EZ+ql0P8kQYM6MC1JXEshvu5qDMKuqcPv0dGPrhYT9+yJcF/7jZfBsys8WlGGDA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI4L20U0TIVZCDEGsflbo7GhRf8lW9K3giHl1aUAxWMNVmfxrTz
	FWsOI9x25ePry6j5iHX2jB3hTWOM1MLorZr42gsUy4P1Ao2m6lXvX6XC+U62FMYjolkS7WZbdTI
	keBQRVKlhakOvv6qlvWfbBlM65GCYJoI=
X-Gm-Gg: AYBFou16MZYznipNPp54OK/hRYmT1gNwirifyfhH76+0EuauqxS5CFSqJkhgQRj6x8U
	icKk7MGRRd2DJUoet17B5AugM/9lXdbg5fAf5YxZjMFOXYcTFYvrAoZDzFaQhtLfIy85CiPrVm1
	ivOU6GGdid4kLne4DVnVL4NiKnvuTNvgUWliodUMYzEwkq6cbemUd1DC04EbE194U3J/521gquU
	8DsZYOv4zuxWvIDBLyBFYhkhEnHjbmoK77ykh/kMZiNp5epYPaoDCgBoIe8alTXubuSz8ni7rfL
	tRS8ukZM1Fu6bvnLJdP3wnaZvgfnonXxP/ub8lOx0xMucRxSTl3cCfvpPcgCF+6f7zcCFLs6OkJ
	9eXsTx/V1YZg9sxn3IlI4/VQO8LB7v/TJVynv
X-Received: by 2002:a17:906:c105:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c46796b58cdmr190770166b.28.1792592812271; Wed, 21 Oct 2026
 07:26:52 -0700 (PDT)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de>
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 21 Oct 2026 16:26:15 +0200
X-Gm-Features: AclHuK9oo5ZYObAiFZur0ih7xDKEBxlKdO-BvoDx6w0mXhpoTx1_PdEXJcogV54
Message-ID: <CAPJSo4UJPnhLFAYRXE-_M2_Nin6=Ff02AjayD10cB7946MvJDQ@mail.gmail.com>
Subject: Adding dreaded Windows SID-style, or. Repeating history, the bad
 chapters. UUID/GUIDRe: [RFC PATCH v2 00/41] UUID and GUID user and group ids
 (*_r system calls)
To: Jan Koester <jan.koester@tuxist.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs <linux-nfs@vger.kernel.org>, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, audit@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 13:24, Jan Koester <jan.koester@tuxist.de> wrote:
>
> Hi,
>
> this RFC series lets a user or group id be a UUID (RFC 9562, version 4)
> or a Microsoft GUID as well as a classic 32-bit number. Processes can run
> as such a user, files can be owned by one, and credentials, ACLs, keys,
> System V IPC, sockets, signals, audit and procfs carry the whole id.

Are you Linnux guys aware that this is just a variation of the
*DREADED* Windows SID that this patch tries to introduce, just with a
new name?
Maybe, before doing this, read about Windows SIDs, and why they are so hated.

Secondly, the whole idea of doing 128bit hashes as UUID is not new,
IBM DFS had it, and had many iterations of security issues via hash
collision exploits. 40 years later all this horror comes back. Does
history really have to repeat itself?

Lionel
