Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D833D503
	for <audit@vger.kernel.org>; Thu, 12 Mar 2026 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349290; cv=none; b=HF+hvXj4cdvmsqbQNxVSyB8JXs6n3K06ueTxoZM+VWPZIUZLIR+L9ww/KVcHxPcJx9vBjJGZN62cX4msdYvZPQGnP0zHIhDydaiCEceaN6qMX4t8MVESJjkL9cd4biul062LsO7Wc4jf9gSLKZ8GeNqBv6kOnB9Dy4li311BldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349290; c=relaxed/simple;
	bh=2m0TEEdToE0XfmBlxsTZbLjAe5WXrhF8lZof/Tgjw3A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Pm2G5hHc95X27izl0CVFy4AbsbyrYkA90rnfQSG+xCwbl2XI+8XBpnbQu4QyJN0AKe7TZwoha+8JRGZS/pZlncQDEx1wbLA9s91Aw+ynsSZgAcJ2pZ6Ct7PylS83Wml8xwnXQGFjtEp17mqjv+evfSm4sExARzZWGyS/HVwLB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY71qaVz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY71qaVz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso1154001f8f.3
        for <audit@vger.kernel.org>; Thu, 12 Mar 2026 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349287; x=1773954087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m0TEEdToE0XfmBlxsTZbLjAe5WXrhF8lZof/Tgjw3A=;
        b=YY71qaVz1Ikyg9nyE+j1p1xLFMUF5CX40C8Bf188Ai9o06NH1OgjglwAuHI2HJ+eKH
         cgUQTg3UCGPWHn6Ym13OoQSfrw6T7X63TKLmYHMTloW0BiwVdvJSLQhjbUck9lxUyLP7
         UFUSwjwQR0xVM3cBqtNYHTi4p+B7wIqArdCNnVzmSMpyEDPebMK97BMSK4yN5rNyIXbr
         b0RRaJ37cFRjXohQwk5c1VxZ7NkLH5Eof1Edhs0Yz8Q7nKZvLg5BYLRw36mwE0qmJjyJ
         +ZOP37kdvywkqMehhmOdS1qVkJ86cNcRoIQ0ueVoKfPalsjn0Ui353RAKySLh0JWg+h5
         LiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349287; x=1773954087;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2m0TEEdToE0XfmBlxsTZbLjAe5WXrhF8lZof/Tgjw3A=;
        b=SxqLwbTNcvJmVOcPTkf04WwINUntZ6s9DBk+AhlkQrZ/i2l2CLUmOwNAMIdX45vvQo
         kFBkycQyoL7t6VL28cfoSXnf2W58hPSqdi8MxlFThNX6/liH+y3KksxXL92b8btrFJ8z
         WApQpdtqOOxef2quytkOtpSlHUxzqikq/xAIgzGvgI7NW+8NoZeoJYjs74Eo0mD96Vo4
         rc/7cg6w5ZSHoIiCTlYsQ7G+z5uIylR4s7LadqnbH2ejCaltv2yTk6cdFyT5pyZGBeGm
         kA87eikXH5+Om7TUkIQwCgxGSD5JvtBctGmF7fql7gniqUoKnBa4IWZeK/g7HdImhSjc
         IRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSJa8tU2w1PWU4BimX6zmd8IAhIYIVwCfX7Sxs/B50XCfsorOcgisZc0RdLVraeLCloH5rrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5O1vRynUqOCD0vSLzLOHxy8oP7d6PW2aKVQuDd68wDasyxC6
	1SwjtJ5hMI8jyhWeHU+jl3Rd2Qj8OtnYShX/u3KRTCdtF4PFO/icl5ox
X-Gm-Gg: ATEYQzymd6IozRHLiHBC/tQqdr1z7jSLRsE2SNlRE48lBvpSYsVjvfLR91l/xSomPyG
	KT/mBfaBLl4byBy1KkcwxHz7Xz1kMUuWBWabXfhRq/S8oVBUa9+bq7GOk0KjFh5omeE2TiIU0a3
	2rYsXiJkRwvYNmkdIsOUqgsKOQj20QIs/5wfIMjgNKSX7W2WIruGOwB5Q+EYyqk4tC6VnfF8tmJ
	F+/TVgwRdmKTpnHIwrV5NDXYAEADpv7xdAeMt3e77FKp9NaxRLKjn5OmzfgfOx5izA3gbbk9+pg
	TCTwGSL1d6ppa4T/IOxkwbYVp32Ju8DmFLXOeYP10BUPXZurh9YNcDOwaVkSAJUuPPrrEf/C5vH
	R8Yn4k1v1TMe7/X7WygNUyhKD6Wgmr9cKf2j8jLa0yDM8nycWxP4095/cz1GGmau6MiVZ8uWAhy
	9F7YMGBOWE/W3SFSdpTRNSv+lClpMgJHLD3rpNYYQkPhDdmb0YTwk6mdAvuLFp5eCQQIxQ9cuOu
	68TtF7KM4FYvxyNKlE=
X-Received: by 2002:a05:6000:220e:b0:439:b541:a088 with SMTP id ffacd0b85a97d-43a04dc8654mr1897210f8f.54.1773349287324;
        Thu, 12 Mar 2026 14:01:27 -0700 (PDT)
Received: from [192.168.1.14] (mm-214-205-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.205.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22f3a4sm11813928f8f.38.2026.03.12.14.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:01:26 -0700 (PDT)
Message-ID: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
Date: Fri, 13 Mar 2026 00:01:25 +0300
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Roman Bakshansky <bakshansky.lists@gmail.com>
Subject: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: linux-api@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 libc-alpha@sourceware.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I'd like to share a draft RFC proposing a complete overhaul of the legacy
binary logs used for authentication auditing in Linux: lastlog, btmp, utmp,
and wtmp.

These files, designed decades ago, are running into fundamental limitations:

- Y2038 problem - they use 32-bit timestamps (time_t in lastlog,
   tv_sec in utmpx). Even on 64-bit systems the fields remain 32-bit
   due to ABI constraints, so all Linux systems are affected.
- No extensibility - any new field (e.g., container ID, service name,
   source IP) requires changing fixed structures, breaking all existing
   tools that read them.
- Poor query performance - tools like last, lastb, who have to
   scan whole files linearly; with millions of records this becomes
   painfully slow.
- No atomicity - partial writes during a crash can corrupt logs.
- Concurrency bottlenecks - multiple writers (sshd, login, etc.)
   contend for the same file with coarse locking.

To address this once and for all, the RFC proposes replacing these logs
with dedicated shared libraries that use SQLite as the storage backend:

- liblastlog2 - last login time
- libbtmp2    - failed login attempts
- libutmp2    - current sessions
- libwtmp2    - login/logout history

SQLite brings:
- 64-bit time -> Y2038 solved forever.
- Indexes -> O(log N) queries instead of full scans.
- Extensible schema -> new fields can be added without breaking old tools.
- ACID and WAL mode -> atomic writes and concurrent access.
- Portability - runs on any Linux system, no systemd dependency.

The full RFC, including preliminary database schemas and API drafts,
is available in the discussion repository:

     https://github.com/bakshansky/linux-auth-logs

I'm looking for feedback on the overall direction, the proposed
interfaces, and the open questions listed in the document (e.g.,
library naming, database location, fallback options for embedded
systems). Please use GitHub Issues for comments, or reply to this
thread - I'll monitor both.

Thanks for your time and input!

