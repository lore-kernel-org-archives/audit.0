Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7AA36B06D
	for <audit@vger.kernel.org>; Fri, 13 Mar 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424166; cv=none; b=j1lgNATOHER2zQQk48q3ABKn5VsHoA4LByWOOFGJyhlD4q1HODpsH70fHoFTrDCG0TdNZgjXMyk9a4JwjLKt5bQwR6NIv2rhlJ4BwzVkPtwsxDEEjnwtSzPdnETMbfNrfrWbdc8gc/4jwvvaZl3yjkeGqpeVZj5s8HveUF3ysPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424166; c=relaxed/simple;
	bh=jiQQcjdZ3RmJlj3rSZZ5hfm4vJpvPPyDRtyiT0auJzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aipKf5h83Oa7RMX1gDjqVGhJIWCLWJlu7kjsmb8i0Y7QWeMpfwz/9+Bytnzo87vE0kVa8OVniIkDTGWiJ+f98YivAq7klnwSm84QtOkYr4OZrqHj90pGuaVU5ckT3GRrBXHdZpYc5KQthrwcChApNHenMdDJkfnmIvs32PloueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1SD4U/s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1SD4U/s"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so22091015e9.2
        for <audit@vger.kernel.org>; Fri, 13 Mar 2026 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773424164; x=1774028964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smbNB81N26gfiTAXqk/YsdxZ2z/tk9SBnFNRELJ+/kU=;
        b=m1SD4U/stEe3uugL61yybyZDYlgofCa2nQ0dENCZa5G/VtmLnDFgvgEtJHmYNGBhcP
         jd8NRi3gHJjuptgMapHMSYisGys/tH8W3O2KpjRcxK0GZDIv+ggBco9cJ1WEkZrKmEUv
         OPkh8e1dZqVHsw0FyTVTWl6NSisBEDA6u73KZayqe3fHDgdOwBtfbquDEVgy+ELerL0K
         kEk3jkmkmUsk0LouqJsHiiG59HjiGzVx2Tk625N77GtoHEaT6f7ydUCRYq4Fy7N8qrPX
         H2km6O/B8ukY0vZH17jOEGM3QKkleTeuQVnpzcrdd1VnogIPqG5HdzdNKugtRq8EmTkL
         KTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424164; x=1774028964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smbNB81N26gfiTAXqk/YsdxZ2z/tk9SBnFNRELJ+/kU=;
        b=icEjD3Yp2l+tb3glKNLNXMQtCFdRrZJ6VwDJ0T08pgnRxXEei+SEm/vzn3MEQGpIR+
         KMC5oyQfw9OQd82TxMDg7JHxGFWe8d85M6M5SIOqwbUmcMa9g1rshlJFDugI/C/i2eKI
         SMBBD6ir5AubqL29+VQTOxYHm6eBtuuz2us+DNEGYAPj9c2GJTmvP1F2TsDhpNI+IcRB
         IOQULx6Tj2k9MAXlMdcFuq1mHi2G2WfjZYWNiGRPFWzOkdSGjObpU7p/+MO6tooU3qb6
         9U7EilhQImaTu948KAWGYe5C0ooj/y+ygPmrhm8ADx7zrMQkukNMoXM+M8PUbylIFTZ1
         4ziQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8gLfFSaj02eN/wbBVMvO8BLe88dM2I8tX6AmVjVOAGeFU4RJzXU7JSwVgmLX5EtKHXj3GEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfB7GLjTenLuxe55FVL4IDu01kHnZ6Q2XFPTSQcyoHQLfFIax
	oWFHOW5hcJoEVO/rzaadWao+FrRsKHecamyK1LnXEH8br4kfL1d+LsgJ
X-Gm-Gg: ATEYQzxq2YZd/noDSxXm9PVsiTsTw+yHb1VjqUlJfLf90L5K8Xr7/1FeKeI2JOiWKMg
	x992T4mYGsRahx+PikFCB0PZkIJIiIGEdVlWvq81rV4wKIfghrICX3+tvIcU7iGQQoehhyVAxkO
	absSvF8YMt5um2wI58ojYWhhy4qiqjT0mRrHwoqwkCsr32ig9AmX8oGmqpKFbb2K5RQ3aSp6YGE
	xQuQkmtjoidc+55m4+IHjzln1JQJcKoOcPr7CHtubwaa+WaaNxncGzNlEZ2TSluxTCtWEBvbGl4
	ZdCc/cWrj0Ib3cmxWGJSvDlMn+gXdn1wPzt249HD301moGBrRtmxXwme2WPGCeN0lEh4Mf6tcaj
	5ZB8ILyV+9v3AuJkeeUlpqwwWN6B7aNBCPqFDNwppx92GGUHd8mwcVfWfEzmcrCdnvW8eMLeKyU
	y2rosPO3jmOYtPNrLUshz5KzldzWQFoIgXLWWG1XUZDqP+5N6fOJv8cp4wP1QoqAowMQZ8XNZsG
	5ahZ47/
X-Received: by 2002:a05:600c:19d2:b0:483:703e:4ad9 with SMTP id 5b1f17b1804b1-485567027e6mr73766635e9.19.1773424163760;
        Fri, 13 Mar 2026 10:49:23 -0700 (PDT)
Received: from [192.168.1.14] (mm-214-205-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.205.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563953dbsm52070925e9.0.2026.03.13.10.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 10:49:23 -0700 (PDT)
Message-ID: <d2832130-5512-4a8f-918a-4e20a77df1b0@gmail.com>
Date: Fri, 13 Mar 2026 20:49:22 +0300
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: Vincent Lefevre <vincent@vinc17.net>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 linux-api@vger.kernel.org, Thorsten Kukuk <kukuk@suse.com>,
 linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 libc-alpha@sourceware.org
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
 <20260313144508.GA5446@cventin.lip.ens-lyon.fr>
Content-Language: en-US
From: Roman Bakshansky <bakshansky.lists@gmail.com>
In-Reply-To: <20260313144508.GA5446@cventin.lip.ens-lyon.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/26 5:45 PM, Vincent Lefevre wrote:
> FYI, utmp has been reintroduced in Debian for libutempter (and thus
> applications that use this library), because systemd was not working
> or at least not sufficiently documented:
>
>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1125682
Thank you for the link to the Debian bug. This example has further 
convinced me that I am on the right track and that such an RFC is indeed 
needed by the community.
