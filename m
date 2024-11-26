Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807FE1D5CC5
	for <audit@vger.kernel.org>; Tue, 26 Nov 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633134; cv=none; b=GqQzy/1HE+q9sMnLwKjl8xmSs2JolvsQOxd7yLVUlEy8XeNe38ddMZoFRc4aVvO/nRkKrbcrIwRMCEkDhGgGecnhAzP7wFfeQF3jcs204T1svQkM5JDZzsVfXnc+xSeyowVqVAPA4jaCaYv9D7SZGlWmV8WLRduvkn3k165PD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633134; c=relaxed/simple;
	bh=f1O+zS6/2cw4GKBLIQEa42J3lPvxfz8RoK+Zaaqew1w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aCbfRq2z8m678U8bGUW8ME4jrpDTgZJUUHR4i9LuBONCbiIgb6YQZCibqeofkrWyoh42ZoQ15vVkUcWi7Gy8MPns69U+pOoE8DWr8yxO3Fo3Aed6Ae/sJ/IAa9cFFm6nSNS5uyn/TZbgHyPY66Sij+e+eLxiW1m046JGs0VkkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOWb5iT4; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOWb5iT4"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f1dfb0b44dso1090445eaf.2
        for <audit@vger.kernel.org>; Tue, 26 Nov 2024 06:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732633131; x=1733237931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7nCMLG4jiyHQ5656b8U7nuMRUbyTISDMqgTqAM6PrCg=;
        b=mOWb5iT4UilRxYkfdkukAvLULyE1yRBQK3wV8iSQnkJyBoehWibRwzW9U6XkbZKQeF
         TX2CbeVqsPaPee7k2BOJKv5U+pi2Dd18wyYysZcQtJTDJZ5gkkHjNdD/KHeZj+ZxP6i8
         E/dwaJBcYli0ld7dqYe+AO5nEFCPKzqBqdAzCs9vaQ1mVQZKsb47NkUo3dNShv+4mffk
         +GxLvDBhGkiCWZv3c22KuiT5iOrKxZjFy3naDl+1zvHDOKWxfM2Ynb0MT4Na/qy4wWl5
         1Gw35i1HcV5iwzZW8ZWW5v+ZcwouKeUMxYl9a9+nulZ9t/xuGmx8NKpq9DSiVl/uOL1h
         /KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633131; x=1733237931;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nCMLG4jiyHQ5656b8U7nuMRUbyTISDMqgTqAM6PrCg=;
        b=NL69vez+EfBWdF6cMXXpN+eRbYLX4NZiE25P4F0OAWolwqh15ngkDiZS3oiVLmMFsx
         VRMRih+pQK/qmTgkgn0IbrqHaW5ZjQDvCziPkS6y3jgmzQf4f6w2hEPsUT11ndGnWw+k
         QeSCbCUtPVCHOpEB1UgwbNRhf7s9UwA5NQYnZpnnWET910uYm0bqB4cIpNrrGKXLV89d
         +CAp/NXDscpbxUO88yRpajZmP5q72mK9AE8PojAYzGyk3v9g2Mv+nkD3MYc7K7/xO9Lg
         l1zUfMnJDOChTr58f7qsGOSTY9NkULj/39Zbtis9ok6Q6f1LySs6qxx0qZNVlVb/6S+B
         8KNQ==
X-Gm-Message-State: AOJu0Yzxw4tsqasGvFqzyvwB12qAOjrZdGmJwAEyYcJommVJuOWERifc
	W8TRgnUqNqN9HM6j/ssY5kbo+LI1FDCyd1L6G0w5sKnmRprmSRRY1QZ/Z0NZTj5PeHG76nbUf5W
	viQnUGnSsNZW/TA+VEdBuYTKvmHfc/ujqU2NG9YXSJqPe9fkpQG8=
X-Gm-Gg: ASbGncv1Kv2ha9U+niHdcF2cdwqU+xkF4nuA0TMIFeDO5FUwsfQjubqOfHqyplly7j7
	Dl98C1dtrePUFcrTDyybOBgt3h1UPgdXea+FWBAgw6p1OE0d4X+oRxgTaMKSP
X-Google-Smtp-Source: AGHT+IGRSy8nLCOB5VUyzmDCr9fGOBYudcymDUxbY3GaTKPYQmQrsAEqrNE0VfI0dc92xgcP+9l1NMxeYbAjVcNZnXQ=
X-Received: by 2002:a05:6358:3120:b0:1c3:7275:491 with SMTP id
 e5c5f4694b2df-1ca796d0650mr815761355d.1.1732633131139; Tue, 26 Nov 2024
 06:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Nov 2024 20:28:40 +0530
Message-ID: <CA+G9fYvWkS-8f9kOBTzixjGSNN8262StoVv2ERk7mRKcU+p+BA@mail.gmail.com>
Subject: include/linux/fortify-string.h:293:17: error: call to
 '__write_overflow' declared with attribute error: detected write beyond size
 of object (1st parameter)
To: audit@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: eparis@redhat.com, Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 hardening.config builds failed on the Linux mainline master
for the arm64 architectures.

First seen on Linux mainline master 7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5.
  Good: 9f16d5e6f220661f73b36a4be1b21575651d8833
  Bad:  7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5

arm64:
  build:
    * gcc-8-lkftconfig-hardening
    * gcc-13-lkftconfig-hardening

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
---------
In function 'sized_strscpy',
    inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
include/linux/fortify-string.h:293:17: error: call to
'__write_overflow' declared with attribute error: detected write
beyond size of object (1st parameter)
  293 |                 __write_overflow();
      |                 ^~~~~~~~~~~~~~~~~~
In function 'sized_strscpy',
    inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
include/linux/fortify-string.h:293:17: error: call to
'__write_overflow' declared with attribute error: detected write
beyond size of object (1st parameter)
  293 |                 __write_overflow();
      |                 ^~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:229: kernel/auditsc.o] Error 1

Build image:
-----------
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNLRwWNgNgfh4C67CGISDtalxY/
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.12-9567-g7eef7e306d3c/testrun/26066025/suite/build/test/gcc-13-lkftconfig-hardening/log
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.12-9567-g7eef7e306d3c/testrun/26066025/suite/build/test/gcc-13-lkftconfig-hardening/details/
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.12-9567-g7eef7e306d3c/testrun/26066025/suite/build/test/gcc-13-lkftconfig-hardening/history/

Steps to reproduce:
------------
- # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13 \
--kconfig defconfig \
--kconfig-add https://gitlab.com/Linaro/lkft/kernel-fragments/-/raw/main/netdev.config
\
--kconfig-add hardening.config

metadata:
----
  git describe: v6.12-9567-g7eef7e306d3c
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git sha: 7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNLRwWNgNgfh4C67CGISDtalxY/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNLRwWNgNgfh4C67CGISDtalxY/
  toolchain: gcc-13 and gcc-8
  config: hardening.config
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org
