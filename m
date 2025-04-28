Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575A26A1A3
	for <audit@vger.kernel.org>; Mon, 28 Apr 2025 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846700; cv=none; b=DV3xzxcSQuOgmKbt1xX4kLb/Id0DS4zh87dyO/CYEWqePYM242wJfil6KOlbbN+HuIhOse35sFcHVNQtuwxBBbQBmD0sm/gd10RgUaCFcp8UdApfKwK3JT5KGN56Dea0snXPZgTOHmh7ugokEjvS+v1Lf+K7XZ86O5S/YxKZzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846700; c=relaxed/simple;
	bh=WMDF+xF8cv9egZiq3dKhKzV9V89Oqq0Xru+OujRAu9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT6g85Zv3uWK/q1kfAGIVVzFNdelVmz9oJLts6hvOfVjNMli17QHFSiD/T/YvmuMuD6IxaGX+NcEffSrns8Y0TUn+CdRa1JHewbEkezJnaI3Vmq+HarViPV0zKyTn4xrhHZXeXHPQLHGyrh2mDjeq9y3BqAMpCgcLqeI5Mdccyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a8/rmBUs; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a8/rmBUs"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so32309936d6.2
        for <audit@vger.kernel.org>; Mon, 28 Apr 2025 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745846697; x=1746451497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TghuZvI1NqWY2rKkKrKVWO9Hy4Hhr0amNahvHhrH2wo=;
        b=a8/rmBUst1R9TjBHzyC3Rl7He+DPBljFvXOcSbBhR/iXiGfg8dhPtUruErD1PurwRF
         4iIwOaP5OEoCakNzjmeJrvaTZi9rKQw8WWQOzq+RLwEU44e6S/zd6vaZKKYRvDLRFUjr
         pvR/iim0F6OwB1KDOxLWgXP/kpivOnv1Rk4OXflqTxOB6tuOwQG731NTd4W1nJozoNZg
         2KOHnJRBLn2XPFftZMmZnSTSop5FBFFrARRX8XTgI4OSNdISm2YRr5l9HaOi6HoMUqgH
         /FAu8Cz46qvmwCc42MtXg2LBI7o+UDjBcMbBCmay0+Efgt/eItjoiv4MpYat6yJUj8wK
         wNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846697; x=1746451497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TghuZvI1NqWY2rKkKrKVWO9Hy4Hhr0amNahvHhrH2wo=;
        b=tydEZg5nIkMjGwGHF9/YKD1z9IglJweV87ZZoXylNUGf6CEXuyHB0h6CWoO6vHCmPZ
         Gjpdd3WncjDYtKSB4YNOKqDPH1VTa89mDuW6UGr42O4UJVo68wD7LOTcsozjDsdm/g2q
         qtkrCk8eJMmzmPluANsaOgbFN1UBuDvaMeRHSwk8y5HTIcZIwm6cs4zikhN2ynNE1GGP
         UjjpwzKpwK0YsJwNkGOtX6BMIFBwzEeZtS5RWxJReEpVmju8b3RPo0Uv8387woS7jT4c
         MrvMkOaxQjlWlbQ2KrveQRjcRTWAn9Bm9JWRPDtRlWOLpVgxDBI8kR7gRVEUBcn7SYqp
         6/6g==
X-Forwarded-Encrypted: i=1; AJvYcCUI0YhKdmsSS5JKuSNld7ElF+eeZEBr8+GoicFJPCJuI0fsxvzTU99UCDheoRU3YG72k4k8vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtWHZJx0ZrPM39etMt5aghiTy5NHf4eQZPt/gtZDUXlH8WXu7
	ZZKep+xZtgHemsbBfUQGvmQV6Jgg/p46XijFR/d7K1sTozCVo3heKK3SLHUxzfA=
X-Gm-Gg: ASbGncss3emUcTMZdvktxcKOAhrx3VQMDqaZHTa/H48CUSofZo1mT8N7heyd42S5Eqa
	ycpR+5k6mkChlsInVVDaVKno9o26PknbXBxLZbih/P5OXTQImCwfHJek8I/81REPMNuPfb2vofZ
	VBUe7BDw7aFF3K8OiDn7yNcwB6Nib7t6qulHy2LWfA7NInz606kXI8/qkSwqE9RRP84b81VoqXL
	z3TKeCfg3N2IZcwEzhiY7PYghm5AW3PNPD9sDCgRRYoA7nQFIIkDkKSAPh8ktnMXdEz1jH0Arin
	2oUN84B9l9ogNUkwz6PagMrG7JxaJnq2sfemGFELVNSUxwwo8EtpwGEaDDeOcoZDf0wKjSkhNcT
	uo7GtdMduvse1VVWiGiQ=
X-Google-Smtp-Source: AGHT+IHS+LiKPwUgJdOq9cWDDSpsQLmT0n1tW9M/V5tmDv3MAmBTgvwZIZ3Uzue2gsWFtJHsf7k49Q==
X-Received: by 2002:ad4:5746:0:b0:6eb:1e80:19fa with SMTP id 6a1803df08f44-6f4cb99d537mr193763226d6.1.1745846696983;
        Mon, 28 Apr 2025 06:24:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0968a44sm61218186d6.60.2025.04.28.06.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:24:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9OTf-00000009Tsv-49gX;
	Mon, 28 Apr 2025 10:24:56 -0300
Date: Mon, 28 Apr 2025 10:24:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Cc: kvm@vger.kernel.org, Chathura Rajapaksha <chath@bu.edu>,
	Alex Williamson <alex.williamson@redhat.com>,
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
Message-ID: <20250428132455.GC1213339@ziepe.ca>
References: <20250426212253.40473-1-chath@bu.edu>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426212253.40473-1-chath@bu.edu>

On Sat, Apr 26, 2025 at 09:22:47PM +0000, Chathura Rajapaksha wrote:
> Some PCIe devices trigger PCI bus errors when accesses are made to
> unassigned regions within their PCI configuration space. On certain
> platforms, this can lead to host system hangs or reboots.

Do you have an example of this? What do you mean by bus error?

I would expect the device to return some constant like 0, or to return
an error TLP. The host bridge should convert the error TLP to
0XFFFFFFF like all other read error conversions.

Is it a device problem or host bridge problem you are facing?

> 1. Support for blocking guest accesses to unassigned
>    PCI configuration space, and the ability to bypass this access control
>    for specific devices. The patch introduces three module parameters:
> 
>    block_pci_unassigned_write:
>    Blocks write accesses to unassigned config space regions.
> 
>    block_pci_unassigned_read:
>    Blocks read accesses to unassigned config space regions.
> 
>    uaccess_allow_ids:
>    Specifies the devices for which the above access control is bypassed.
>    The value is a comma-separated list of device IDs in
>    <vendor_id>:<device_id> format.
> 
>    Example usage:
>    To block guest write accesses to unassigned config regions for all
>    passed through devices except for the device with vendor ID 0x1234 and
>    device ID 0x5678:
> 
>    block_pci_unassigned_write=1 uaccess_allow_ids=1234:5678

No module parameters please.

At worst the kernel should maintain a quirks list to control this,
maybe with a sysfs to update it.

Jason
