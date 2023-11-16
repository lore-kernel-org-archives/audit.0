Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ceoK0HoD"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E41A8
	for <audit@vger.kernel.org>; Thu, 16 Nov 2023 10:36:17 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789cc5c8ccso97112285a.0
        for <audit@vger.kernel.org>; Thu, 16 Nov 2023 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700159777; x=1700764577; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFS/mwZ3/EMPWQv8aFv2yBhjsP3bkWDq8nS9+OIYTm4=;
        b=ceoK0HoDSrGdd7Nfl/LT94wHU8u9n0WMujqUE4uMP1d5PnWECBfTyqDd/NfwNcxavx
         u5EEj02DGrRi+FYXYVbBhfYt9QtvUj3jR+vvW+dHoY5+KwRAe2IxHLsXc9zqW5+uYPRK
         ZyMnIhfgtrBT2RkFBl+AbjYeGUFnQmaMqAH0MUmrosIs34Pm4Aanq2xmkkGi2ho7Gpiq
         Oc8ncqO66qBnvvbBFOh7Pioa9b0U++4M+4Zb4D0eFyIRMd5+caDI45C/t0rhMFHFSqnS
         HCcyy3uynQwBr8HUbjPuoo5jy68XtH34o7zkA4+TcjdAwwZEKntKK2QnABSZtEUEj8S4
         yf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700159777; x=1700764577;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFS/mwZ3/EMPWQv8aFv2yBhjsP3bkWDq8nS9+OIYTm4=;
        b=TvZNAeesBjYxIJX97Zify7rn13iiPy9hxqnFt1OnDr2DKOjCxNn5U8Y2N9OnFd1kj3
         jX7KyBC2EHGMbRG6xGRF9APWskHNjtaCoXs3xuHhsrJN7gNgJj/BtkUPIZPYSdkUepjk
         Z0DZfkqGeH3J/EmP4HxOwZlbBhWAhuZLg/7lGCvasJFuY3It4UD3JqJoygba52F0Rp5H
         xfrVP1IgSl11UGtuO4cguZOGju0j7tEDx+8MvuEZ4fq119f+DNbcofG7kD0HuQPXJY1M
         9zeMpBbKmpnTUMUTPZLfJnK/wVT1xT2FB/WpeoJPK9rHGVoN+SZFxkcHFyM5HoGq8CVS
         J1xg==
X-Gm-Message-State: AOJu0YwWJN5Yd+PzyWH00zu24WygZocQSKDZGLq3IH/fOs+BmW1Wubv/
	YiAWYlI3g3ad50QCa7aagmo7
X-Google-Smtp-Source: AGHT+IGJoyomQm/pmBe6nkCyLo/F12BgpdpfzeHoSwE6LR04rQx4RUiHgfajMV/4nXhhyUdS8DVx/A==
X-Received: by 2002:a05:620a:254a:b0:778:969e:3a0c with SMTP id s10-20020a05620a254a00b00778969e3a0cmr3471880qko.27.1700159776751;
        Thu, 16 Nov 2023 10:36:16 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pr13-20020a05620a86cd00b007770d47c621sm5830qkn.66.2023.11.16.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:36:16 -0800 (PST)
Date: Thu, 16 Nov 2023 13:36:15 -0500
Message-ID: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20231116
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Hi Linus,

One small audit patch to convert a WARN_ON_ONCE() into a normal
conditional to avoid scary looking console warnings when eBPF code
generates audit records from unexpected places.  Please merge.

Thanks,
-Paul

--
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20231116

for you to fetch changes up to 969d90ec212bae4b45bf9d21d7daa30aa6cf055e:

  audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()
    (2023-11-14 17:34:27 -0500)

----------------------------------------------------------------
audit/stable-6.7 PR 20231116

----------------------------------------------------------------
Paul Moore (1):
      audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com
