Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353262D0279
	for <audit@vger.kernel.org>; Tue, 29 Apr 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934252; cv=none; b=Zqh4ggCgZLLBIQlsuBATZsYWTSA/TVCYdOksJ1xO4B9rScyBSedAuiR+OLaBcissLbAysj3rewY2uYiitfKV/avrTkp/eqXJZf/XBAVuVNDCBvWaxwyQ4Aec428tWIAF1YVC7jfM9JpP5MSNh6YTQFw1FmwQewOEWXaB7iRpz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934252; c=relaxed/simple;
	bh=khgmom5SwYGkHlS7uWpIwHY3reFluKKZuIoug5wMJyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTAv5ImFBn72y3sYF0eOsyBLH40SqLAYLExbgI7bTADD6vwGx/f4MC9MwioJG0art6r1eXRcOmYM5/SaU6am/JqDHaUxuOX60Mo6tt/SFqeg6ZyNDdiUL1PprBIDNPok4kNDJGiU/cI1scpnzkvQ82RYxnlZNTmby/dGRSBqCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R2NcB7Cx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R2NcB7Cx"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c559b3eb0bso357222985a.1
        for <audit@vger.kernel.org>; Tue, 29 Apr 2025 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745934250; x=1746539050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3NiznvmeEzk9qrZsVXzuwmh6VHSrphUuExjP4cJOHk=;
        b=R2NcB7Cx6w3QyVhqCCyu6Om5rClVB54CDe52fxvmuoZcyvHL+WfAKyMhGKpETH9rQX
         9fYepbzsdZzYfoeYdEOdbIHodJ5JAnFzW4RRXQdaJ5hGjNND6QggmrDAtnf0M84h1i3D
         W7+O3cC8FnnMOjMgmfILqNSokB6uVSwLOKkFy6OmCO6vno36wxc5ezG8a7HMRAT4gFsz
         16vn4Wn6486gQkK5AGlXrS0vwb7VR8ma1wXzChBLms/zSdMRMglj4lqbNTFUugtSnYEL
         QEhmJhsrXWlnf8OwZUoza3nFE4q4MgtAyt/dRmIHR2y01sA8JEjLEU9mxTVg1AD/Qftp
         5IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934250; x=1746539050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3NiznvmeEzk9qrZsVXzuwmh6VHSrphUuExjP4cJOHk=;
        b=hNcd6bZvzpu0ND0ZuSPajT2WghzxJzIEdjwk8FvTLX/JXQFUoEqZntvmJNY5DKTlNm
         DU7yUfstmSvcv/OLZ763SFExi9acJTD7DXqB3m5+skGAO0x3nE09O02T6wTnAZEf4OzF
         A2wSGhlto9RFCs/upr0ctQcaPvn0sbi/Egr0P5IhZcyGYmbk1JExRX9PRUte1FlqN8Ql
         4ZhjT85vutFAEWKqkR/2IVWWozu4rVEsd6uhQve9DI9lm1JWxqQM+MH2Sa8c5nDsEFd6
         euLDPfZsGq59uPkNMChLWutX7oxm8papZN2lTmo6hfU5bklLq/PebYb+KWAKa4uiBzhe
         Nk6w==
X-Forwarded-Encrypted: i=1; AJvYcCUa2n5C4knt3UvP7JEOKjsNfXvXbluui3oOuUzRzfCF2MoCJbNLyIaJQp10xjUlSldiPmYmEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylC/XJLfXwkenrZ7ZsSLM3ePdMqTvgTseoD3z6n+IoK0cY85LK
	cl6G4xAp84WyhDHe+5wf2FiWN9QDY0VjqTPqf/1ed1XAbQUJyaWpRv48J896u9I=
X-Gm-Gg: ASbGncvo4iBqVG1IeX1C/uqnY3jkGyvRJSotcsNFzciCiO/rsd8+1Lt5015gOHeL2ND
	RsUCzsWhrMsUtmP6OyhE9btSyOnf153tLP4ZmySNUckeR6+SxmFDiOhrQI5m6uKo+T/W1v6NzaR
	TRMLcjyb93/pIKgajjNkCwcuCBSXKipznNiVtsCjYfGmnM8dBap2vZU5D3gNOtoU5XA891DZO0q
	RQ1a8rHK2J73Yr/NyTqMJbzL/76LGT5md/mwY811+23iMKRkAmBJJlz3geTAaqnGIz40GRZ1xEW
	7QdbPtT5w/x0dPDEtexrbWp+BV5DLi+0aho/wv5auGpFYHRY9ORy6R+xCCcGttjlnd+e/5tjDgy
	w5d7PVXMqPOhA34Lq/VY=
X-Google-Smtp-Source: AGHT+IGa21onp27WGYH0jVBo4uRP+h7kSdtwA1BovLylZ30nroRsVmISeIOqnDPjCHw9jw8dVdXUhQ==
X-Received: by 2002:a05:620a:3951:b0:7c5:602f:51fc with SMTP id af79cd13be357-7cabddaf5f3mr490871385a.44.1745934249986;
        Tue, 29 Apr 2025 06:44:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c921b4sm743361685a.19.2025.04.29.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:44:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9lFo-0000000AAmR-34V3;
	Tue, 29 Apr 2025 10:44:08 -0300
Date: Tue, 29 Apr 2025 10:44:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>,
	kvm@vger.kernel.org, Chathura Rajapaksha <chath@bu.edu>,
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Xin Zeng <xin.zeng@intel.com>, Yahui Cao <yahui.cao@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Yunxiang Li <Yunxiang.Li@amd.com>,
	Dongdong Zhang <zhangdongdong@eswincomputing.com>,
	Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
	audit@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] vfio/pci: Block and audit accesses to unassigned
 config regions
Message-ID: <20250429134408.GC2260621@ziepe.ca>
References: <20250426212253.40473-1-chath@bu.edu>
 <20250428132455.GC1213339@ziepe.ca>
 <20250428142558.263c5db1.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428142558.263c5db1.alex.williamson@redhat.com>

On Mon, Apr 28, 2025 at 02:25:58PM -0600, Alex Williamson wrote:

> PCI config space is a slow path, it's already trapped, and it's
> theoretically architected that we could restrict and audit much of it,
> though some devices do rely on access to unarchitected config space.
> But even within the architected space there are device specific
> capabilities with undocumented protocols, exposing unknown features of
> devices.  Does this incrementally make things better in general, or is
> this largely masking a poorly behaved device/system?

I think there would be merit in having a qemu option to secure the
config space.

We talked about this before about presenting a perscribed virtualized
config space.

But we still have the issue that userpace with access to VFIO could
crash the machine, on these uncontained platforms, which is not great.

It would be nice if the kernel could discover this, but it doesn't
seem possible. There is so much in the SOC design and FW
implementation that has to be done correctly for errors to be properly
containable.

Jason
