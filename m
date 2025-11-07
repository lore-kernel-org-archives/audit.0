Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06464274B58
	for <audit@vger.kernel.org>; Fri,  7 Nov 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555584; cv=none; b=JoYGuzFrWNeVRpWIqIyptLMVaKm/yUb5gggy4uTYN8jOe7k4QA3zjX2g3qvzCp1smZ6mav7pCF4BCjDj4VLGZ3a7S3BctHMDYk6tMQZt4DfWsuA3YtBTAi0jGlOiPgz044SqHJ+ZeSDxsTebSqzYC1T52nFD+NIv3e6GJM6UcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555584; c=relaxed/simple;
	bh=exM2y4bXCjZMQxm7NJdgWLyhnwqAYQhkw/iId3BFS+8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=DWO9I3+YMKMiErP4EYf7i1ZS57AAb8WOtjxUzjhcIM6shUVibAwQG3US3DwSZyoBtmRt0csPg4/yJeH8H+A1gYNjIR/QPIdENzu9CZ5jYvVmsxtfXnLIwgkwR0DgsrTYGAccYSjMljGIkTlY2yDZVLPnLB3LjTVFpgX8SnMkMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KVYUmF+4; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KVYUmF+4"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89048f76ec2so127957485a.1
        for <audit@vger.kernel.org>; Fri, 07 Nov 2025 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762555582; x=1763160382; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkmPvv21zjwIVzkW8sxRUn2RFjg0W7CBZpQyks/0r2w=;
        b=KVYUmF+4V85J7wkDvBX3yrVHN5+YA71d5bxsyxqohUm2OmHoZwGu9JWjnf0UhwtVvO
         pW4QIjxXvTG5Ix+VkbzhoPxxUsPK4C6sZa69vVq4BohCiqNBFnYS7pNeBbG2h9J+7HKc
         4qCPr27R6XCpoUPA1rNEPqwZrcYlpC21iUzho/0/oqa3hMFManvilFCpf+iACvMbKxzt
         RMljVYOJXELWE8fQzf8jdQYPtEtofibVTvfb4vJ+P61bX5nDzbDk02HEUhwqzN3ATSji
         io+vgmyxH+Nb+j+j2uieD0odIG+HYtwb6vXjj03Oj2ucT/sEVYYDEpyFww+eEHsy/Dnw
         SVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555582; x=1763160382;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkmPvv21zjwIVzkW8sxRUn2RFjg0W7CBZpQyks/0r2w=;
        b=xQmXD/jUwQv4/8GfIKM8iemGUnek7XMamLynHmwYuLv7qoNtg67SB5mxSEoKFrzIZ2
         yvT9ByjFKSzepJpW6DJBORj7PAh39HasWgtxrZYCliCcvnj8NLZGDmwbr9r9eslO0VEk
         Wq9LEMpPA/2eFlN//mVZznPu4PlTp0loP2vEY88PiXrbW5frXAGsxLL6ZGumCn/tVcuh
         +RkCrLmRW/aEGZRXrNHK+uVw03wvR/liEgalYSG9J4DA8wiGEUvwWTx32ki9gdAgEuL2
         xRxEt1WwQ4figbZNg3FcuIEP9WIBJ4oQgCsWidF4Wg+UOHI2oTyGuEqPoYjNwBP5gfxS
         Lodw==
X-Forwarded-Encrypted: i=1; AJvYcCWrMIIiFSz1I3GDFpaIRWwxBlW4iiAkrq6KB/7CXKLthQ3KBorx2dh4RAQ3I9csHMWPkHokvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7fhYh6Y5RrekV79THW3OfhIN6LST7mZwzuzjR/cM3MKMIOOf+
	S1Z7LBSAdWiCImzHaQrnFBzGVPFaMmW9ZaUHr1gB7W2y2vSRHrnZ3ITL/RJ0qb/WMXWHFo3CbQ5
	mTRo=
X-Gm-Gg: ASbGncsOPJkBs8ZNP+gZNM2G9ILp0Obvy3/0iHNK8SAa5BJnBmgD7KIF3sZ/syjilgk
	3tQwlkaK5LxudSHD92XUqMIb5Mrt77QfK5hIWRTEjtPm6kNw7b222sDeXId9KmEcB1KFGCe/W6A
	G3IASBtRfeHoxSrG5BaMvp7tPlN1Ho019LzMSOYBJK2mzAMwZ1TioPQnMgrrAY0SfHZHrMWfxlt
	gYqksgQvBhur2XTmecSg0hajzUxsvSAyeROBcoCJ6meAR1qRWFvBQr0uRDU2Y/ypOF3S61KTPfX
	+15MCfG1XaMUD9Y6LlfSbJ6P6Ujf3wQjjfOTMybVm7bijNDUm/W1pK2vFQ86svN9yzOmdvIAjSr
	3Jcwme6lbHjKfqOGRD3jiIEM5+CvkQgDt+SSdr/EKYZmKw0laUQ57epE/LhWg6q0+OgNAckV64w
	9limcth+5KGYD6SVNCMnKy9qfU39cwvdFmqQfNQbGQCn803X81uj/q0zua
X-Google-Smtp-Source: AGHT+IGW2w5cYMyEJm74NZs2gDmZaOfaiPNwFh5FQ3KOXZnvYLTWQ2yOy1B0NxEYIggNl+tUwAUNgQ==
X-Received: by 2002:a05:620a:4153:b0:892:8439:2efa with SMTP id af79cd13be357-8b257f02acemr121709485a.23.1762555581926;
        Fri, 07 Nov 2025 14:46:21 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c334dsm512663685a.12.2025.11.07.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:46:20 -0800 (PST)
Date: Fri, 07 Nov 2025 17:46:20 -0500
Message-ID: <a396108e2b9f19f0c453a44c8e7be873@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251107_1632/pstg-lib:20251107_1737/pstg-pwork:20251107_1632
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc: eparis@redhat.com, fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v5 2/2] audit: include source and destination ports to  NETFILTER_PKT
References: <b44ec08fbb011bc73ad2760676e0bbfda2ca9585.1762434837.git.rrobaina@redhat.com>
In-Reply-To: <b44ec08fbb011bc73ad2760676e0bbfda2ca9585.1762434837.git.rrobaina@redhat.com>

On Nov  6, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> NETFILTER_PKT records show both source and destination
> addresses, in addition to the associated networking protocol.
> However, it lacks the ports information, which is often
> valuable for troubleshooting.
> 
> This patch adds both source and destination port numbers,
> 'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
> SCTP-related NETFILTER_PKT records.
> 
>  $ TESTS="netfilter_pkt" make -e test &> /dev/null
>  $ ausearch -i -ts recent |grep NETFILTER_PKT
>  type=NETFILTER_PKT ... proto=icmp
>  type=NETFILTER_PKT ... proto=ipv6-icmp
>  type=NETFILTER_PKT ... proto=udp sport=46333 dport=42424
>  type=NETFILTER_PKT ... proto=udp sport=35953 dport=42424
>  type=NETFILTER_PKT ... proto=tcp sport=50314 dport=42424
>  type=NETFILTER_PKT ... proto=tcp sport=57346 dport=42424
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/162
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Acked-by: Florian Westphal <fw@strlen.de>
> ---
>  kernel/audit.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 4 deletions(-)

This looks fine to me, although it may change a bit based on the
discussion around patch 1/2.  However, two things I wanted to comment
on in this patch:

- Please try to stick to an 80 char line width for audit code.  There are
obvious exceptions like printf-esque strings, etc. but the
skb_header_pointer() calls in this patch could be easily split into
multiple lines, each under 80 chars.

- This isn't a general comment, but in this particular case it would be
nice to move the protocol header variables into their associated switch
case (see what I did in patch 1/2).

--
paul-moore.com
